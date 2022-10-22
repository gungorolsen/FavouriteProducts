//
//  Endpoints.swift
//  FavouriteProducts
//
//  Created by Olsen Gungor on 22/10/2022.
//

struct Endpoints {
    
    private static let baseUrl = "https://run.mocky.io/"
    
    enum Endpoint {
        case productList
        
        var path: String {
            switch self {
            case .productList: return "v3/2f06b453-8375-43cf-861a-06e95a951328"
            }
        }
    }
    
    static func getUrlString(endpoint: Endpoint) -> String {
        baseUrl + endpoint.path
    }
}
