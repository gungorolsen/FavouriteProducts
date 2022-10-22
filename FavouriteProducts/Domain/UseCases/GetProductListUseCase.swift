//
//  GetProductListUseCase.swift
//  FavouriteProducts
//
//  Created by Olsen Gungor on 22/10/2022.
//

protocol GetProductListUseCase {
    func getProductList() async throws -> [Product]
}

class GetProductListUseCaseImpl {
    
    private let productListRepo: ProductListRepo
    
    init(productListRepo: ProductListRepo = ProductListService()) {
        self.productListRepo = productListRepo
    }
}

extension GetProductListUseCaseImpl: GetProductListUseCase {
    
    func getProductList() async throws -> [Product] {
        try await productListRepo.getProductList()
    }
}
