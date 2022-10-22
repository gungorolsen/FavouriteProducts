//
//  ProductListService.swift
//  FavouriteProducts
//
//  Created by Olsen Gungor on 22/10/2022.
//

class ProductListService {

    // MARK: Properties
    
    private let httpClient: HTTPClientType
    private let mapper: ProductListMapping
    
    // MARK: Initialiser
    
    init(httpClient: HTTPClientType = HTTPClient(),
         mapper: ProductListMapping = ProductListMapper()) {
        self.httpClient = httpClient
        self.mapper = mapper
    }
}

extension ProductListService: ProductListRepo {
        
    func getProductList() async throws -> [Product] {
        let response: ProductListResponse = try await httpClient.dataTaskPublisher(urlString: urlString)
        return try mapper.mapToDomain(from: response)
    }
    
    private var urlString: String {
        Endpoints.getUrlString(endpoint: .productList)
    }
}

