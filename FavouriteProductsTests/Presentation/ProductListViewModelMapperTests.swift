//
//  TabbarTests.swift
//  FavouriteProductsTests
//
//  Created by Olsen Gungor on 22/10/2022.
//

import XCTest
@testable import FavouriteProducts

class ProductListViewModelMapperTests: XCTestCase {
    
    private var mapper: ProductListViewModelMapper!

    override func setUpWithError() throws {
        mapper = ProductListViewModelMapper()
    }

    override func tearDownWithError() throws {
        mapper = nil
    }
    
    func testMap() throws {
        let viewModels = mapper.map([MocksData.product1])
        XCTAssertFalse(viewModels.isEmpty)
        XCTAssertEqual(viewModels.first?.name, "bar")
        XCTAssertEqual(viewModels.first?.price, "Price: $10.00")
        XCTAssertEqual(viewModels.first?.rating, "Rating: 1 out of 5")
        XCTAssertEqual(viewModels.first?.addToButtonText, "btn")

    }
    
}
