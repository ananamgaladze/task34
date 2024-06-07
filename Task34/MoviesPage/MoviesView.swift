//
//  MoviesView.swift
//  Task34
//
//  Created by ana namgaladze on 05.06.24.
//

import SwiftUI

struct MoviesView: View {
    @EnvironmentObject var viewModel: MoviesViewModel
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    private var columns: [GridItem] {
        if horizontalSizeClass == .compact {
            return [GridItem(.flexible())]
        } else {
            return [GridItem(.flexible()), GridItem(.flexible())]
        }
    }
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    var body: some View {
        NavigationStack {
            if viewModel.isLoading && viewModel.movies.isEmpty {
                ProgressView("Loading movies...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(1.5)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.movies, id: \.id) { movie in
                            MovieGridItem(movie: movie)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Movies")
                .background(.bPurple)
                .onAppear {
                    viewModel.fetchMovies()
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
