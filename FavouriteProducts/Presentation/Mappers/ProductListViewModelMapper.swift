//
//  ProductListViewModelMapper.swift
//  FavouriteProducts
//
//  Created by Olsen Gungor on 22/10/2022.
//

import Foundation

class ProductListViewModelMapper {
    
    func map(_ products: [Product]) -> [ProductViewModel] {
        products.map {
            ProductViewModel(product: $0, currencyFormatter: currencyFormatter, numberFormatter: numberFormatter)
        }
    }
    
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
}
