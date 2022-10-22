//
//  HttpClient.swift
//  FavouriteProducts
//
//  Created by Olsen Gungor on 22/10/2022.
//

import Foundation

enum HttpError: Error {
    case invalidResponse
    case failure(code: Int)
    case invalidURL(url: String)
}


protocol HTTPClientType {
    func dataTaskPublisher<T: Decodable>(urlString: String) async throws -> T
}

class HTTPClient: HTTPClientType {
    
    private let urlSessionProvider: URLSessionProviding
    
    init(urlSessionProvider: URLSessionProviding = URLSessionProvider()) {
        self.urlSessionProvider = urlSessionProvider
    }
    
    func dataTaskPublisher<T: Decodable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw HttpError.invalidURL(url: urlString)
        }
    
        let (data, response) = try await urlSessionProvider.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw HttpError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw HttpError.failure(code: httpResponse.statusCode)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}

protocol URLSessionProviding {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

class URLSessionProvider: URLSessionProviding {
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        try await URLSession.shared.data(from: url)
    }
}
