//
//  MovieListResponse.swift
//  MovieWalk
//
//  Created by Kyuhong Jo on 5/27/24.
//

import Foundation

struct MovieListResponse: Codable {
    let Search: [MovieResponse]
    let totalResults: String
    let Response: String
}

struct MovieResponse: Codable {
    let Title: String
    let Year: String
    let imdbID: String
    let Poster: String
}
