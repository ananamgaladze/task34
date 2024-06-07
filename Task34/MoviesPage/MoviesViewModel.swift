//
//  MoviesViewModel.swift
//  Task34
//
//  Created by ana namgaladze on 05.06.24.
//

import Foundation
import Networking

final class MoviesViewModel: ObservableObject {

    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var currentPage: Int = 1
    private var totalPages: Int = 1
    //ჩაწერეთ რამდენი გვერდიც თქვენს გულს გაუხარდება ;) <3
    private let maxPagesToFetch = 10

    func fetchMovies() {
        guard !isLoading && currentPage <= maxPagesToFetch else { return }
        isLoading = true

        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=dcad18dcca48dc647c63391f8bbbaa4d&page=\(currentPage)"
        
        NetworkService().getInfo(urlString: urlString) { [weak self] (result: Result<MoviesResponse, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.movies.append(contentsOf: response.results)
                    self.totalPages = response.totalPages
                    self.currentPage += 1
                    self.isLoading = false
                    
                    if self.currentPage <= self.maxPagesToFetch && self.currentPage <= self.totalPages {
                        self.fetchMovies() 
                    }
                }
            case .failure(let error):
                print("Error fetching movies: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
}
