//
//  ProductListMapper.swift
//  FavouriteProducts
//
//  Created by Olsen Gungor on 22/10/2022.
//

import Foundation

protocol ProductListMapping {
    func mapToDomain(from response: ProductListResponse) throws -> [Product]
}

class ProductListMapper: ProductListMapping {
    
    func mapToDomain(from response: ProductListResponse) throws -> [Product] {
        guard let products = response.products?.compactMap(mapProduct) else {
            throw DomainError.mapping
        }
        return products
    }
    
    private func mapProduct(from response: ProductListResponse.Product) -> Product? {
        guard let id = response.id,
            let title = response.title,
            let price = response.price?.first?.value,
            let addToCartButtonText = response.addToCartButtonText,
            let imageUrlString = response.imageURL, let imageUrl = URL(string: imageUrlString),
            let rating = response.ratingCount else { return nil }

        return Product(id: id, name: title, price: price, addToButtonText: addToCartButtonText, imageUrl: imageUrl, rating: rating)
    }
}
