//
//  ProductListViewModel.swift
//  FavouriteProducts
//
//  Created by Olsen Gungor on 16/10/2022.
//

import SwiftUI

enum ViewState {
    case loading
    case loaded([ProductViewModel])
    case error
}

@MainActor
final class ProductListViewModel: ObservableObject {

    @Published
    var state: ViewState = .loading

    @Published
    var favourites: [ProductViewModel] = []

    let tabbarViewModel = TabbarViewModel()

    private let getProductListUseCase: GetProductListUseCase
    private let favouriteProductsUseCase: FavouriteProductsUseCase
    private let mapper = ProductListViewModelMapper()

    init(
        getProductListUseCase: GetProductListUseCase = GetProductListUseCaseImpl(),
        favouriteProductsUseCase: FavouriteProductsUseCase = FavouriteProductsUseCaseImpl()
    ) {
        self.getProductListUseCase = getProductListUseCase
        self.favouriteProductsUseCase = favouriteProductsUseCase
    }
    
    func refreshProductsList() async {
        state = .loading
        await getAllProducts()
    }
    
    func getAllProducts() async {        
        if case .loaded = state { return }
        
        do {
            let productsList = try await getProductListUseCase.getProductList()
            let productsViewModels = mapper.map(productsList)
            state = .loaded(productsViewModels)
        } catch {
            state = .error
        }
    }
    
    func getTitle(isFavouritesList: Bool) -> String {
        if isFavouritesList {
            return "Your Favourites"
        }
        return "Product List"
    }
    
    func didTapFavouriteButton(for product: Product) {
        favouriteProductsUseCase.addOrRemoveFavourite(product)
    }
    
    func refreshFavourites() {
        favourites = mapper.map(favouriteProductsUseCase.favouriteProducts)
    }
    
    func isFavourite(_ productViewModel: ProductViewModel) -> Bool {
        favouriteProductsUseCase.favouriteProducts.contains(productViewModel.product)
    }

}
