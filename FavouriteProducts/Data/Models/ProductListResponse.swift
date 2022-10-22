//
//  ProductListResponse.swift
//  FavouriteProducts
//
//  Created by Olsen Gungor on 22/10/2022.
//

// MARK: - ProductList
struct ProductListResponse: Decodable {
    let products: [Product]?
    
    // MARK: - Product
    struct Product: Decodable {
        let id: String?
        let title: String?
        let imageURL: String?
        let price: [Price]?
        let ratingCount: Double?
        let addToCartButtonText: String?
    }
    
    // MARK: - Price
    struct Price: Decodable {
        let value: Double?
    }
}
