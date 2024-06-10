//
//  MoviesView.swift
//  Task34
//
//  Created by ana namgaladze on 05.06.24.
//

import SwiftUI

struct MoviesView: View {
    @EnvironmentObject var viewModel: MoviesViewModel
    
    private var columns: [GridItem] {
        Array(repeating: .init(.flexible()), count: 3)
    }
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading && viewModel.movies.isEmpty {
                ProgressView("Loading movies")
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    .scaleEffect(1.5)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.movies) { movie in
                            movieGridItem(for: movie)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Movies")
                .onAppear {
                    viewModel.fetchMovies()
                }
            }
        }
    }
    
    @ViewBuilder
    private func movieGridItem(for movie: Movie) -> some View {
        NavigationLink(destination: MovieDetailView(movie: movie)) {
            VStack {
                ImageLoadingView(url: "https://image.tmdb.org/t/p/w500\(movie.posterPath)", imageSize: 150)
                    .cornerRadius(16)
                
                VStack {
                    Text(movie.title)
                        .foregroundColor(.primary)
                        .padding(.top, 5)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
