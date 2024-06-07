//
//  SearchViewModel.swift
//  Task34
//
//  Created by ana namgaladze on 06.06.24.
//

import Foundation
import Networking

final class SearchViewModel: ObservableObject {

    var moviesViewModel: MoviesViewModel
    @Published var searchTerm: String = ""
    
    init(moviesViewModel: MoviesViewModel) {
        self.moviesViewModel = moviesViewModel
    }


    var filteredMovies: [Movie] {
        return moviesViewModel.movies.filter { $0.title.localizedCaseInsensitiveContains(searchTerm) }
    }
    
}


