//
//  MovieViewModel.swift
//  KUMUvie
//
//  Created by Jerk Nino Magdadaro on 10/25/21.
//

import Foundation

class MovieViewModel: ObservableObject {
    
//    @Published var movies: [MovieModel] = Array()
    
    // Fetch Movies from API
    func fetchMovies() {
        let url = URL(string: "https://itunes.apple.com/search?term=star&country=au&media=movie&all")!
        let request = APIRequest(url: url)
        request.perform { (moviesResponse: Response?) -> Void in
//            self?.movies = moviesResponse?.results ?? []
            
            // Save response to CoreData MovieInfo Entity
            if let movies = moviesResponse?.results {
                PersistenceController.shared.insertMovie(movies: movies)
            }
            
        }
    }
    
}
