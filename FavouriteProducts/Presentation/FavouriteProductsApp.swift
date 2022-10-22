//
//  FavouriteProductsApp.swift
//  FavouriteProducts
//
//  Created by Olsen Gungor on 16/10/2022.
//

import SwiftUI

class Test {
    func test() {
        Task {
            let url = "https://run.mocky.io/v3/2f06b453-8375-43cf-861a-06e95a951328"
            let response: ProductListResponse = try await HTTPClient().dataTaskPublisher(urlString: url)
            print(response)
        }
    }
}

@main
struct FavouriteProductsApp: App {
    

    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
