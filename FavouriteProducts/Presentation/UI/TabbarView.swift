//
//  TabbarView.swift
//  FavouriteProducts
//
//  Created by Olsen Gungor on 22/10/2022.
//

import SwiftUI

struct MainView: View {
    
    @StateObject
    var viewModel = ProductListViewModel()
        
    var body: some View {
        TabView {
            ProductListView(isFavouritesList: false)
                .tabItem {
                    Label(viewModel.tabbarViewModel.getTabbarTitle(for: .list),
                          systemImage: viewModel.tabbarViewModel.getTabbarImage(for: .list))
                }

            ProductListView(isFavouritesList: true)
                .tabItem {
                    Label(viewModel.tabbarViewModel.getTabbarTitle(for: .favourites),
                          systemImage: viewModel.tabbarViewModel.getTabbarImage(for: .favourites))
                }
        }
        .environmentObject(viewModel)
    }
}
