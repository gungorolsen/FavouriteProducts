//
//  ProductListRepo.swift
//  FavouriteProducts
//
//  Created by Olsen Gungor on 22/10/2022.
//

protocol ProductListRepo {
    func getProductList() async throws -> [Product]
}
