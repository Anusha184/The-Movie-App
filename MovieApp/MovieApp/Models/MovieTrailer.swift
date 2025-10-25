//
//  MovieTrailer.swift
//  MovieApp
//
//  Created by Anusha on 25/10/25.
//

import Foundation

struct MovieTrailerResponse: Decodable {
    let results: [Trailer]?

    struct Trailer: Decodable, Identifiable {
        let id: String
        let key: String?
        let name: String?
        let site: String?
        let type: String?
    }
}
