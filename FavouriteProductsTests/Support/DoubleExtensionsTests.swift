//
//  DoubleExtensionsTests.swift
//  FavouriteProductsTests
//
//  Created by Oguzhan Gungor on 23/10/2022.
//

import XCTest
@testable import FavouriteProducts

class DoubleExtensionsTests: XCTestCase {

    func testToNumberFunction() {
        XCTAssertEqual(Double(10).toNumber(), NSNumber(value: 10))
        XCTAssertEqual(Double(0).toNumber(), NSNumber(value: 0))
        XCTAssertEqual(Double(-10).toNumber(), NSNumber(value: -10))
    }
}
