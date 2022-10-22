//
//  GetProductListUseCaseTests.swift
//  FavouriteProductsTests
//
//  Created by Olsen Gungor on 22/10/2022.
//

import XCTest
@testable import FavouriteProducts

class GetProductListUseCaseTests: XCTestCase {

    private var useCase: GetProductListUseCase!
    private var productListService: ProductServiceMockingSpy!

    override func setUpWithError() throws {
        productListService = ProductServiceMockingSpy()
        useCase = GetProductListUseCaseImpl(productListRepo: productListService)
    }

    override func tearDownWithError() throws {
        productListService = nil
        useCase = nil
    }

    func testHappyPath() async throws {
        productListService.returnedProducts = [MocksData.product1]
        let products = try await useCase.getProductList()
        XCTAssertNotNil(products)
    }
    
    func testUnhappyPath() async throws {
        do {
            _ = try await useCase.getProductList()
            XCTFail()
        } catch {}
    }
}

class ProductServiceMockingSpy: ProductListRepo {    
    var returnedProducts: [Product]?
    func getProductList() async throws -> [Product] {
        if let returnedProducts = returnedProducts {
            return returnedProducts
        }
        throw DomainError.mapping
    }
}
