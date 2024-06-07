//
//  SearchView.swift
//  Task34
//
//  Created by ana namgaladze on 05.06.24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel: SearchViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    init(viewModel: SearchViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private var columns: [GridItem] {
        if horizontalSizeClass == .compact {
            return [GridItem(.flexible())]
        } else {
            return [GridItem(.flexible()), GridItem(.flexible())]
        }
    }
    

    var body: some View {
        NavigationStack {
            ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.filteredMovies, id: \.id) { movie in
                            MovieGridItem(movie: movie)
                        }
                    .padding()
                }
            }
            .navigationTitle("Movies")
            .searchable(text: $viewModel.searchTerm, prompt: "Search Movies")
        }
    }
}

#Preview {
    ContentView()
}

