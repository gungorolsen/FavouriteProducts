//
//  FavouriteProductDao.swift
//  FavouriteProducts
//
//  Created by Olsen Gungor on 17/10/2022.
//

import Foundation

protocol FavouriteProductsDao {
    func getFavouriteProducts() -> [Product]?
    func setFavouriteProduct(_ product: Product)
    func removeFavouriteProduct(_ product: Product)
}

class FavouriteProductsDaoImpl {
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
}

extension FavouriteProductsDaoImpl: FavouriteProductsDao {
    
    func getFavouriteProducts() -> [Product]? {
        if let data = userDefaults.data(forKey: "fav.products") {
            return try? JSONDecoder().decode([Product].self, from: data)
        }
        return nil
    }
    
    func setFavouriteProduct(_ product: Product) {
        var existingFavourites = getFavouriteProducts() ?? []
        existingFavourites.append(product)
        let data = try? JSONEncoder().encode(existingFavourites)
        userDefaults.set(data, forKey: "fav.products")
    }
    
    func removeFavouriteProduct(_ product: Product) {
        var existingFavourites = getFavouriteProducts() ?? []
        existingFavourites.removeAll { $0.id == product.id }
        let data = existingFavourites.isEmpty ? nil : try? JSONEncoder().encode(existingFavourites)
        userDefaults.set(data, forKey: "fav.products")
    }
}
