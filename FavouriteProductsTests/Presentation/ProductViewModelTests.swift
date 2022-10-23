//
//  ProductViewModelTests.swift
//  FavouriteProductsTests
//
//  Created by Olsen Gungor on 22/10/2022.
//

import XCTest
@testable import FavouriteProducts

class ProductViewModelTests: XCTestCase {
    
    private var viewModel: ProductViewModel!
    
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    private lazy var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "AUD"
        formatter.currencySymbol = "$"
        return formatter
    }()
    
    @MainActor
    override func setUpWithError() throws {
        viewModel = ProductViewModel(product: MocksData.product1,
                                     currencyFormatter: currencyFormatter,
                                     numberFormatter: numberFormatter)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testDisplayData() async throws {
        XCTAssertEqual(viewModel.name, "bar")
        XCTAssertEqual(viewModel.price, "Price: $10.00")
        XCTAssertEqual(viewModel.addToButtonText, "btn")
        XCTAssertEqual(viewModel.imageUrl, URL(string: "https://google.com"))
        XCTAssertEqual(viewModel.rating, "Rating: 1 out of 5")
    }
}
