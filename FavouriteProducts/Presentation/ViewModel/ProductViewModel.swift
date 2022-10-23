//
//  ProductViewModel.swift
//  FavouriteProducts
//
//  Created by Olsen Gungor on 16/10/2022.
//

import SwiftUI

final class ProductViewModel: ObservableObject, Identifiable {

    let product: Product
    let currencyFormatter: NumberFormatter
    let numberFormatter: NumberFormatter


    init(product: Product,
         currencyFormatter: NumberFormatter,
         numberFormatter: NumberFormatter) {
        self.product = product
        self.currencyFormatter = currencyFormatter
        self.numberFormatter = numberFormatter
    }
    
    var name: String { product.name }
    
    var price: String {
        "Price: " + (currencyFormatter.string(from: product.price.toNumber()) ?? "N/A")
    }
    var addToButtonText: String { product.addToButtonText }
    
    var imageUrl: URL { product.imageUrl }
    
    var rating: String {
        "Rating: " + (numberFormatter.string(from: product.rating.toNumber()) ?? "0") + " out of 5"
    }
    
    var id: String { product.id }
}
