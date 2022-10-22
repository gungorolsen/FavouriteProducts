//
//  ProductListView.swift
//  FavouriteProducts
//
//  Created by Olsen Gungor on 22/10/2022.
//

import SwiftUI

struct ProductListView: View {
    
    @EnvironmentObject
    private var viewModel: ProductListViewModel
    
    private let isFavouritesList: Bool

    init(isFavouritesList: Bool) {
        self.isFavouritesList = isFavouritesList
    }
    
    var body: some View {
        
        NavigationView {
            contentView
                .navigationTitle(viewModel.getTitle(isFavouritesList: isFavouritesList))
                .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            if isFavouritesList {
                viewModel.refreshFavourites()
            } else {
                await viewModel.getAllProducts()
            }
        }
    }

    var contentView: some View {
        if isFavouritesList {
            return favouriteListView
        }
        return productListView
    }
    
    var favouriteListView: AnyView {
        if viewModel.favourites.isEmpty {
            return AnyView(Text("No favourites"))
        }
        return AnyView(
            getListView(for: viewModel.favourites)
                .onAppear {
                    viewModel.refreshFavourites()
                }
            )
    }

    var productListView: AnyView {
        switch viewModel.state {
        case .loading:
            return AnyView(ProgressView().progressViewStyle(.circular).transition(.opacity))
        case .error:
            return AnyView(
                Button {
                    Task { await viewModel.refreshProductsList() }
                } label: {
                    Text("Refresh list")
                }.padding()
            )
        case .loaded(let products):
            return AnyView(getListView(for: products))
        }
    }

    private func getListView(for products: [ProductViewModel]) -> some View {
        List(products, id: \.id) { product in
            NavigationLink {
                ProductView(product: product, isProductSummary: false)
                    .navigationTitle(product.name)
            } label: {
                ProductView(product: product, isProductSummary: true)
            }
        }
    }
}
