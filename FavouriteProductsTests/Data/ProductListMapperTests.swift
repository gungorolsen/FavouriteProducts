//
//  HttpClientTests.swift
//  FavouriteProductsTests
//
//  Created by Olsen Gungor on 16/10/2022.
//

import XCTest
@testable import FavouriteProducts

class ProductListMapperTests: XCTestCase {

    private var productListMapper: ProductListMapping!

    override func setUpWithError() throws {
        productListMapper = ProductListMapper()
    }

    override func tearDownWithError() throws {
        productListMapper = nil
    }

    func testSuccessfulMap() throws {
        let domainObj = try? productListMapper.mapToDomain(from: MocksData.successfulProductListResponse)
        XCTAssertNotNil(domainObj)
        XCTAssertEqual(domainObj?.count, 1)
        XCTAssertEqual(domainObj?.first?.id, "foo")
        XCTAssertEqual(domainObj?.first?.name, "bar")
        XCTAssertEqual(domainObj?.first?.addToButtonText, "button")
        XCTAssertEqual(domainObj?.first?.price, 10)
        XCTAssertEqual(domainObj?.first?.imageUrl, URL(string: "http://google.com"))
        XCTAssertEqual(domainObj?.first?.rating, 3.4)
    }

    func testNilMap() throws {
        XCTAssertThrowsError(
            try productListMapper.mapToDomain(from: MocksData.nilProductListResponse)
        )
    }
    
    func testMalformedMap() throws {
        let domainObj = try? productListMapper.mapToDomain(from: MocksData.malformedProductListResponse)
        XCTAssertEqual(domainObj?.count, 0)
    }

}
