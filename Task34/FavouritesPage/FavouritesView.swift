//
//  FavouritesView.swift
//  Task34
//
//  Created by ana namgaladze on 09.06.24.
//

import SwiftUI

struct FavouritesView: View {
    @EnvironmentObject var favoritesViewModel: FavouritesViewModel

    var body: some View {
        NavigationStack {
            if favoritesViewModel.favorites.isEmpty {
                VStack {
                    Text("No Favourites Yet")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .bold()

                    Text("All movies marked as favourite will \nbe added here")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .navigationTitle("Favourites")
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(favoritesViewModel.favorites) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                MovieCell(movie: movie)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
                .navigationTitle("Favourites")
            }
        }
    }
}

#Preview {
    ContentView()
}
