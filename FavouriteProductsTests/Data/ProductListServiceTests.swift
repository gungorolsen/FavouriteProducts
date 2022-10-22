//
//  HttpClientTests.swift
//  FavouriteProductsTests
//
//  Created by Olsen Gungor on 16/10/2022.
//

import XCTest
@testable import FavouriteProducts

class ProductListServiceTests: XCTestCase {

    private var productListService: ProductListRepo!
    private var mockHttpClient: MockHttpClient!

    override func setUpWithError() throws {
        mockHttpClient = MockHttpClient()
        productListService = ProductListService(httpClient: mockHttpClient)
    }

    override func tearDownWithError() throws {
        mockHttpClient = nil
        productListService = nil
    }

    func testSuccessfulCall() async throws {
        mockHttpClient.returnedResponse = MocksData.successfulProductListResponse
        let productList = try await productListService.getProductList()
        XCTAssertEqual(productList.count, 1)
    }

    func testUnsuccessfulCall() async throws {
        do {
            let _ = try await productListService.getProductList()
            XCTFail()
        } catch {
            XCTAssertEqual(error as? HttpError, .invalidResponse)
        }
    }
}

class MockHttpClient: HTTPClientType {

    var returnedResponse: Decodable?
    func dataTaskPublisher<T: Decodable>(urlString: String) async throws -> T {
        if let returnedResponse = returnedResponse as? T {
            return returnedResponse
        }
        throw HttpError.invalidResponse
    }
}
