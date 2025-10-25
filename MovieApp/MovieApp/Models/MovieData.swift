//
//  Untitled.swift
//  MovieApp
//
//  Created by Anusha on 24/10/25.
//

import Foundation

struct MovieResponse: Decodable {
    let page: Int?
    let results: [MovieData]?
    let totalPages: Int?
    let totalResults: Int?
}

struct MovieData: Identifiable, Decodable {
    let id: Int
    let title: String?
    let voteAverage: Double?
    let posterPath: String?
    let overview: String?
    let runtime: Int?
    let genres: [Genre]?
    var isFav: Bool?
}

struct Genre: Decodable, Identifiable {
    let id: Int
    let name: String?
}
