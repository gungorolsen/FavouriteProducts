//
//  MockData.swift
//  FavouriteProductsTests
//
//  Created by Olsen Gungor on 22/10/2022.
//

import Foundation
@testable import FavouriteProducts

struct MocksData {
    static let successfulProductListResponse = ProductListResponse(
        products: [.init(id: "foo",
                         title: "bar",
                         imageURL: "http://google.com",
                         price: [.init(value: 10.0)],
                         ratingCount: 3.4,
                         addToCartButtonText: "button")
        ]
    )

    static let nilProductListResponse = ProductListResponse(products: nil)
    
    static let malformedProductListResponse = ProductListResponse(
        products: [.init(id: nil,
                         title: "bar",
                         imageURL: "http://google.com",
                         price: [.init(value: 10.0)],
                         ratingCount: 3.4,
                         addToCartButtonText: "button")
        ]
    )

    static let product1 = Product(id: "foo",
                                  name: "bar",
                                  price: 10,
                                  addToButtonText: "btn",
                                  imageUrl: URL(string: "https://google.com")!,
                                  rating: 1)

    static let product2 = Product(id: "foo2",
                                  name: "bar",
                                  price: 10,
                                  addToButtonText: "btn",
                                  imageUrl: URL(string: "https://google.com")!,
                                  rating: 1)

    static let invalidResponse1 = HTTPURLResponse(url: URL(string: "http://localhost:8080")!,
                                                  statusCode: 400,
                                                  httpVersion: nil,
                                                  headerFields: nil)
    
    static let invalidResponse2 = URLResponse(url: URL(string: "http://localhost:8080")!,
                                              mimeType: nil,
                                              expectedContentLength: 0,
                                              textEncodingName: nil)

    static let validResponse = HTTPURLResponse(url: URL(string: "http://localhost:8080")!,
                                               statusCode: 200,
                                               httpVersion: nil,
                                               headerFields: nil)
}
