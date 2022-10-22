//
//  Product.swift
//  FavouriteProducts
//
//  Created by Olsen Gungor on 22/10/2022.
//

import Foundation

struct Product: Codable {
    let id: String
    let name: String
    let price: Double
    let addToButtonText: String
    let imageUrl: URL
    let rating: Double
}

extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
}
