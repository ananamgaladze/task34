//
//  FavouritesViewModel.swift
//  Task34
//
//  Created by ana namgaladze on 09.06.24.
//

import Foundation

final class FavouritesViewModel: ObservableObject {
    @Published var favorites: [Movie] = [] {
        didSet {
            saveFavorites()
        }
    }

    private let favoritesKey = "favorites"

    init() {
        loadFavorites()
    }

    func addToFavorites(_ movie: Movie) {
        if !favorites.contains(where: { $0.id == movie.id }) {
            favorites.append(movie)
        }
    }

    func removeFromFavorites(_ movie: Movie) {
        favorites.removeAll { $0.id == movie.id }
    }

    func isFavorite(_ movie: Movie) -> Bool {
        favorites.contains(where: { $0.id == movie.id })
    }

    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }

    private func loadFavorites() {
        if let savedFavorites = UserDefaults.standard.object(forKey: favoritesKey) as? Data {
            if let decodedFavorites = try? JSONDecoder().decode([Movie].self, from: savedFavorites) {
                favorites = decodedFavorites
            }
        }
    }
}
