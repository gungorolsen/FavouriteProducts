//
//  FavouriteProductsUseCase.swift
//  FavouriteProducts
//
//  Created by Olsen Gungor on 18/10/2022.
//

protocol FavouriteProductsUseCase {
    var favouriteProducts: [Product] { get }
    func addOrRemoveFavourite(_ product: Product)
}

class FavouriteProductsUseCaseImpl {
    
    private let dao: FavouriteProductsDao
    
    init(dao: FavouriteProductsDao = FavouriteProductsDaoImpl()) {
        self.dao = dao
    }
}

extension FavouriteProductsUseCaseImpl: FavouriteProductsUseCase {

    var favouriteProducts: [Product] {
        dao.getFavouriteProducts() ?? []
    }
    
    func addOrRemoveFavourite(_ product: Product) {
        if favouriteProducts.contains(product) {
            dao.removeFavouriteProduct(product)
        } else {
            dao.setFavouriteProduct(product)
        }
    }
}
