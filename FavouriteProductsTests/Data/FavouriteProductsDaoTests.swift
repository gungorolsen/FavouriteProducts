//
//  FavouriteProductsDaoTests.swift
//  FavouriteProductsTests
//
//  Created by Olsen Gungor on 22/10/2022.
//

import XCTest
@testable import FavouriteProducts

class FavouriteProductDaoTests: XCTestCase {

    private var userDefaults: UserDefaults!
    private var dao: FavouriteProductsDao!

    override func setUpWithError() throws {
        userDefaults = UserDefaults(suiteName: "foo")
        dao = FavouriteProductsDaoImpl(userDefaults: userDefaults)
    }

    override func tearDownWithError() throws {
        userDefaults.removePersistentDomain(forName: "foo")
        dao = nil
    }

    func testInitialGetFavourites() throws {
        XCTAssertNil(dao.getFavouriteProducts())
    }
    
    func testGetFavourites() throws {
        let data = try! JSONEncoder().encode([MocksData.product1])
        userDefaults.set(data, forKey: "fav.products")
        XCTAssertNotNil(dao.getFavouriteProducts())
    }
    
    func testSetFavourites() throws {
        XCTAssertNil(userDefaults.data(forKey: "fav.products"))
        dao.setFavouriteProduct(MocksData.product1)
        XCTAssertNotNil(userDefaults.data(forKey: "fav.products"))
    }

    func testRemoveFavourites() throws {
        let data = try! JSONEncoder().encode(MocksData.product1)
        userDefaults.set(data, forKey: "fav.products")
        XCTAssertNotNil(userDefaults.data(forKey: "fav.products"))
        dao.removeFavouriteProduct(MocksData.product1)
        XCTAssertNil(userDefaults.data(forKey: "fav.products"))
    }

    func testRemoveSelectedFavourites() throws {
        let data = try! JSONEncoder().encode([MocksData.product1, MocksData.product2])
        userDefaults.set(data, forKey: "fav.products")
        XCTAssertNotNil(userDefaults.data(forKey: "fav.products"))
        dao.removeFavouriteProduct(MocksData.product2)
        XCTAssertNotNil(userDefaults.data(forKey: "fav.products"))
    }

    func testRemoveFavouritesWhenNoFavourites() throws {
        XCTAssertNil(userDefaults.data(forKey: "fav.products"))
        dao.removeFavouriteProduct(MocksData.product2)
        XCTAssertNil(userDefaults.data(forKey: "fav.products"))
    }

}
