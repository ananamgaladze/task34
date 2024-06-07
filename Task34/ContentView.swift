//
//  ContentView.swift
//  Task34
//
//  Created by ana namgaladze on 05.06.24.
//

import SwiftUI
struct ContentView: View {
    @StateObject var moviesViewModel = MoviesViewModel()
    
    var body: some View {
        let searchViewModel = SearchViewModel(moviesViewModel: moviesViewModel)
        
        TabView {
            MoviesView()
                .tabItem {
                    Image(systemName: "film")
                    Text("Films")
                }
            SearchView(viewModel: searchViewModel)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
        }
        .environmentObject(moviesViewModel)
        .accentColor(.bPurple)
    }
}

#Preview {
    ContentView()
}
