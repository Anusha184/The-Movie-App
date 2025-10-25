//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Anusha on 24/10/25.
//

import Foundation

protocol NetworkManaging {
    func fetchMovies() async throws -> [MovieData]
    func fetchSearchMovies(title: String) async throws -> [MovieData]
    func fetchMovieDetail(id: Int) async throws -> MovieData
    func fetchMovieTrailers(id: Int) async throws -> [MovieTrailerResponse.Trailer]
}

final class NetworkManager: NetworkManaging {
    func fetchMovies() async throws -> [MovieData] {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(APIConfig.apiKey)")  else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let movieResponse = try decoder.decode(MovieResponse.self, from: data)
        return movieResponse.results ?? []
    }
    
    func fetchSearchMovies(title: String) async throws -> [MovieData] {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(APIConfig.apiKey)&query=\(title)")  else {
            throw URLError(.badURL)
        }
        print(url)
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let movieResponse = try decoder.decode(MovieResponse.self, from: data)
        return movieResponse.results ?? []
    }
    
    func fetchMovieDetail(id: Int) async throws -> MovieData {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(APIConfig.apiKey)&language=en-US") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(MovieData.self, from: data)
    }
    
    func fetchMovieTrailers(id: Int) async throws -> [MovieTrailerResponse.Trailer] {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=\(APIConfig.apiKey)&language=en-US") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode(MovieTrailerResponse.self, from: data)
        return response.results?.filter { $0.site?.lowercased() == "youtube" && $0.type?.lowercased() == "trailer" } ?? []
    }
}
