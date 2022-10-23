//
//  ProductListViewModelTests.swift
//  FavouriteProductsTests
//
//  Created by Olsen Gungor on 22/10/2022.
//

import XCTest
@testable import FavouriteProducts

class ProductListViewModelTests: XCTestCase {
    
    private var viewModel: ProductListViewModel!
    private var getProductListUseCase: GetProductListUseCaseMockingSpy!
    private var favouriteProductsUseCase: FavouriteProductsUseCaseMockingSpy!

    @MainActor
    override func setUpWithError() throws {
        getProductListUseCase = GetProductListUseCaseMockingSpy()
        favouriteProductsUseCase = FavouriteProductsUseCaseMockingSpy()
        viewModel = ProductListViewModel(getProductListUseCase: getProductListUseCase,
                                         favouriteProductsUseCase: favouriteProductsUseCase)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    @MainActor
    func testInitialState() async throws {
        XCTAssertEqual(viewModel.state, .loading)
    }

    @MainActor
    func testRefreshList() async throws {
        await viewModel.refreshProductsList()
        XCTAssertTrue(getProductListUseCase.isGetProductListCalled)
    }

    @MainActor
    func testGetProductsWhenViewStateIsLoaded() async throws {
        viewModel.state = .loaded([])
        await viewModel.getAllProducts()
        XCTAssertFalse(getProductListUseCase.isGetProductListCalled)
    }

    @MainActor
    func testGetProducts() async throws {
        getProductListUseCase.returnedProducts = [MocksData.product2]
        await viewModel.getAllProducts()
        
        if case .loaded(let products) = viewModel.state {
            XCTAssertEqual(products.first?.name, "bar")
            XCTAssertEqual(products.first?.rating, "Rating: 1 out of 5")
            XCTAssertEqual(products.first?.price, "Price: $10.00")
            XCTAssertEqual(products.first?.addToButtonText, "btn")
        } else {
            XCTFail()
        }
    }

    @MainActor
    func testGetProductsFailure() async throws {
        await viewModel.getAllProducts()        
        XCTAssertEqual(viewModel.state, .error)
    }

    @MainActor
    func testGetNavigationTitle() throws {
        XCTAssertEqual(viewModel.getTitle(isFavouritesList: true), "Your Favourites")
        XCTAssertEqual(viewModel.getTitle(isFavouritesList: false), "Product List")
    }

    @MainActor
    func testEmptyListTitle() throws {
        XCTAssertEqual(viewModel.getEmptyListTitle(isFavouritesList: true), "No favourites")
        XCTAssertEqual(viewModel.getEmptyListTitle(isFavouritesList: false), "Refresh Product List")
    }

    @MainActor
    func testGetEmptyFavourites() throws {
        viewModel.refreshFavourites()
        XCTAssertTrue(viewModel.favourites.isEmpty)
    }

    @MainActor
    func testGetFavourites() throws {
        favouriteProductsUseCase.returnedProducts = [MocksData.product1]
        viewModel.refreshFavourites()
        XCTAssertFalse(viewModel.favourites.isEmpty)
    }

    @MainActor
    func testIsFavourite() throws {
        favouriteProductsUseCase.returnedProducts = [MocksData.product1]
        let viewModel1 = ProductListViewModelMapper().map([MocksData.product1]).first!
        XCTAssertTrue(viewModel.isFavourite(viewModel1))
        let viewModel2 = ProductListViewModelMapper().map([MocksData.product2]).first!
        XCTAssertFalse(viewModel.isFavourite(viewModel2))
    }

    @MainActor
    func testDidTapFavourite() throws {
        viewModel.didTapFavouriteButton(for: MocksData.product1)
        XCTAssertTrue(favouriteProductsUseCase.isAddOrRemoveFavouriteCalled)
    }

}

class GetProductListUseCaseMockingSpy: GetProductListUseCase {
    var returnedProducts: [Product]?
    private(set) var isGetProductListCalled = false
    func getProductList() async throws -> [Product] {
        isGetProductListCalled = true
        if let returnedProducts = returnedProducts {
            return returnedProducts
        }
        throw DomainError.mapping
    }
}

class FavouriteProductsUseCaseMockingSpy: FavouriteProductsUseCase {
    
    var returnedProducts: [Product]?
    var favouriteProducts: [Product] {
        returnedProducts ?? []
    }
    
    private(set) var isAddOrRemoveFavouriteCalled = false
    func addOrRemoveFavourite(_ product: Product) {
        isAddOrRemoveFavouriteCalled = true
    }
}

extension ViewState: Equatable {
    public static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch(lhs, rhs) {
        case(.loading, .loading): return true
        case(.error, .error): return true
        case(.loaded(let lhsProducts), .loaded(let rhsProducts)): return lhsProducts == rhsProducts
        default: return false
        }
    }
}

extension ProductViewModel: Equatable {
    public static func == (lhs: ProductViewModel, rhs: ProductViewModel) -> Bool {
        lhs.id == rhs.id
    }
}
