//
//  ContentView.swift
//  Task34
//
//  Created by ana namgaladze on 05.06.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var moviesViewModel: MoviesViewModel
    @StateObject private var searchViewModel: SearchViewModel
    @StateObject private var favoritesViewModel: FavouritesViewModel
    
    init() {
        let moviesVM = MoviesViewModel()
        _moviesViewModel = StateObject(wrappedValue: moviesVM)
        let searchVM = SearchViewModel(moviesViewModel: moviesVM)
        _searchViewModel = StateObject(wrappedValue: searchVM)
        let favoritesVM = FavouritesViewModel()
        _favoritesViewModel = StateObject(wrappedValue: favoritesVM)
    }
    
    var body: some View {
        TabView {
            MoviesView()
                .tabItem {
                    Image(.home)
                    Text("Home")
                }
            
            SearchView(viewModel: searchViewModel)
                .tabItem {
                    Image(.loop)
                    Text("Search")
                }
            
            FavouritesView()
                .tabItem {
                    Image(.save)
                    Text("Favourites")
                }
        }
        .environmentObject(moviesViewModel)
        .environmentObject(favoritesViewModel)
        .accentColor(.blue)
    }
}

#Preview {
    ContentView()
}
