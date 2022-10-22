//
//  DomainError.swift
//  FavouriteProducts
//
//  Created by Olsen Gungor on 22/10/2022.
//

import Foundation

enum DomainError: Error {
    case mapping
    case unexpected(Error)
}
