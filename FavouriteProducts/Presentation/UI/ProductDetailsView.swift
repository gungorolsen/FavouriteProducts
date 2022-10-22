//
//  ProductDetailsView.swift
//  FavouriteProducts
//
//  Created by Olsen Gungor on 22/10/2022.
//

import SwiftUI

struct ProductView: View {
    
    @EnvironmentObject
    private var viewModel: ProductListViewModel
    @State
    private var isSelected: Bool = false

    private let product: ProductViewModel
    private let isProductSummary: Bool

    init(product: ProductViewModel, isProductSummary: Bool) {
        self.product = product
        self.isProductSummary = isProductSummary
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            AsyncImage(url: product.imageUrl) { phase in
                (phase.image ?? Image(systemName: "photo"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 80, height: 150, alignment: .center)
            .padding()

            VStack(alignment: .leading) {
                if isProductSummary {
                    Text(product.name)
                }
                Text(product.price)
                if !isProductSummary {
                    Text(product.rating)
                }
                Button(product.addToButtonText) {
                }
            }
            
            Spacer()
            
            Button {
                viewModel.didTapFavouriteButton(for: product.product)
                isSelected = viewModel.isFavourite(product)
                withAnimation {
                    if isProductSummary {
                        viewModel.refreshFavourites()
                    }
                }
            } label: {
                Image(systemName: isSelected ? "star.fill" : "star")
            } .buttonStyle(PlainButtonStyle())
            .padding()
        }.onAppear {
            isSelected = viewModel.isFavourite(product)
        }
        
    }
}

