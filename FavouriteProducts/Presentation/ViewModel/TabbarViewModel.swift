//
//  TabbarViewModel.swift
//  FavouriteProducts
//
//  Created by Olsen Gungor on 22/10/2022.
//

import Foundation

enum TabItem {
    case list, favourites
}

struct TabbarViewModel {
        
    func getTabbarTitle(for tabItem: TabItem) -> String {
        switch tabItem {
        case .list: return "Product List"
        case .favourites: return "Favourites"
        }
    }

    func getTabbarImage(for tabItem: TabItem) -> String {
        switch tabItem {
        case .list: return "list.dash"
        case .favourites: return "star.fill"
        }
    }
}
