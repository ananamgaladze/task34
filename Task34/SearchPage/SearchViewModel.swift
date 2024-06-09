//
//  SearchViewModel.swift
//  Task34
//
//  Created by ana namgaladze on 06.06.24.
//

import Foundation
import Networking

enum FilterType: String, CaseIterable {
    case name = "Name"
    case genre = "Genre"
    case year = "Year"
}

final class SearchViewModel: ObservableObject {
    var moviesViewModel: MoviesViewModel
    @Published var searchTerm: String = ""
    @Published var selectedFilter: FilterType = .name {
        didSet {
            updatePlaceholderText()
        }
    }
    
    @Published var placeholderText: String = "try Spiderman :)"
    
    init(moviesViewModel: MoviesViewModel) {
        self.moviesViewModel = moviesViewModel
        updatePlaceholderText()
    }
    
    var filteredMovies: [Movie] {
        switch selectedFilter {
        case .name:
            return moviesViewModel.movies.filter { $0.title.lowercased().hasPrefix(searchTerm.lowercased()) }
        case .genre:
            return moviesViewModel.movies.filter { movie in
                movie.genres?.contains { $0.name.lowercased().contains(searchTerm.lowercased()) } ?? false
            }
        case .year:
            return moviesViewModel.movies.filter { $0.releaseDate.prefix(4).contains(searchTerm) }
        }
    }
    
    var errorMessage: String {
        switch selectedFilter {
        case .name:
            return "I cannot find any movie with this name."
        case .genre:
            return "I cannot find any movie with this genre."
        case .year:
            return "I cannot find any movie with this release date."
        }
    }
    
    private func updatePlaceholderText() {
        switch selectedFilter {
        case .name:
            placeholderText = "try Spiderman :)"
        case .genre:
            placeholderText = "Search by genre"
        case .year:
            placeholderText = "Search by year"
        }
    }
}
