//
//  EndpointTests.swift
//  FavouriteProductsTests
//
//  Created by Olsen Gungor on 22/10/2022.
//

import XCTest
@testable import FavouriteProducts

class EndpointTests: XCTestCase {

    func testEndpoint() {
        XCTAssertEqual(Endpoints.getUrlString(endpoint: .productList), "https://run.mocky.io/v3/2f06b453-8375-43cf-861a-06e95a951328")
    }
}
