//
//  FavouriteProductsUseCaseTests.swift
//  FavouriteProductsTests
//
//  Created by Olsen Gungor on 22/10/2022.
//

import XCTest
@testable import FavouriteProducts

class FavouriteProductsUseCaseTests: XCTestCase {

    private var useCase: FavouriteProductsUseCase!
    private var dao: FavouriteProductsDaoMockingSpy!

    override func setUpWithError() throws {
        dao = FavouriteProductsDaoMockingSpy()
        useCase = FavouriteProductsUseCaseImpl(dao: dao)
    }

    override func tearDownWithError() throws {
        dao = nil
        useCase = nil
    }

    func testGetFavouritesWhenNil() throws {
        XCTAssertTrue(useCase.favouriteProducts.isEmpty)
    }
    
    func testGetFavourites() throws {
        dao.returnedProducts = [MocksData.product1]
        XCTAssertFalse(useCase.favouriteProducts.isEmpty)
    }

    func testAddFavourite() throws {
        useCase.addOrRemoveFavourite(MocksData.product1)
        XCTAssertTrue(dao.isSetFavouriteProduct)
    }

    func testRemoveFavourite() throws {
        dao.returnedProducts = [MocksData.product1]
        useCase.addOrRemoveFavourite(MocksData.product1)
        XCTAssertTrue(dao.isRemoveFavouriteProduct)
    }
}

class FavouriteProductsDaoMockingSpy: FavouriteProductsDao {

    var returnedProducts: [Product]?
    func getFavouriteProducts() -> [Product]? {
        returnedProducts
    }
    
    private(set) var isSetFavouriteProduct = false
    func setFavouriteProduct(_ product: Product) {
        isSetFavouriteProduct = true
    }
    
    private(set) var isRemoveFavouriteProduct = false
    func removeFavouriteProduct(_ product: Product) {
        isRemoveFavouriteProduct = true
    }

}
