//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Anusha on 25/10/25.
//

import Foundation

@MainActor
final class MovieDetailViewModel: ObservableObject {
    @Published var movie: MovieData?
    @Published var trailerKey: String?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let networkManager: NetworkManaging
    private let movieId: Int

    init(movieId: Int, networkManager: NetworkManaging = NetworkManager()) {
        self.movieId = movieId
        self.networkManager = networkManager
    }

    func fetchDetails() async {
        isLoading = true
        errorMessage = nil
        do {
            async let detail = networkManager.fetchMovieDetail(id: movieId)
            async let trailers = networkManager.fetchMovieTrailers(id: movieId)

            let (movieDetail, movieTrailers) = try await (detail, trailers)
            self.movie = movieDetail
            self.trailerKey = movieTrailers.first?.key
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
