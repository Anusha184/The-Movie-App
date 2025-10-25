//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Anusha on 24/10/25.
//

import Foundation

@MainActor
final class MovieListViewModel: ObservableObject {
    @Published var movies: [MovieData] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let networkManager: NetworkManaging

    init(networkManager: NetworkManaging = NetworkManager()) {
        self.networkManager = networkManager
    }

    func fetchMoviesList() async {
        isLoading = true
        errorMessage = nil
        do {
            let movies = try await networkManager.fetchMovies()
            let favIDs = UserDefaults.standard.array(forKey: "favoriteMovieIDs") as? [Int] ?? []
            self.movies = movies.map { movie in
                var m = movie
                m.isFav = favIDs.contains(movie.id)
                return m
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func fetchSearchMoviesList(title: String) async {
        isLoading = true
        errorMessage = nil
        do {
            let movies = try await networkManager.fetchSearchMovies(title: title)
            let favIDs = UserDefaults.standard.array(forKey: "favoriteMovieIDs") as? [Int] ?? []
            self.movies = movies.map { movie in
                var m = movie
                m.isFav = favIDs.contains(movie.id)
                return m
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func toggleFavorite(movie: MovieData) {
        guard let index = movies.firstIndex(where: { $0.id == movie.id }) else { return }
        movies[index].isFav?.toggle()

        let favIDs = movies.compactMap { $0.isFav == true ? $0.id : nil }
        UserDefaults.standard.set(favIDs, forKey: "favoriteMovieIDs")
    }
}

