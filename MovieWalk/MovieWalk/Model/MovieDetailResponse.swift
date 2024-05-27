//
//  MovieDetailResponse.swift
//  MovieWalk
//
//  Created by Kyuhong Jo on 5/27/24.
//

import Foundation

struct MovieDetailResponse: Codable {
    let Title: String
    let Year: String
    let Released: String
    let Runtime: String
    let Director: String
    let Actors: String
    let Poster: String
    let Plot: String
    let Ratings: [MovieDetailRatingsResponse]
}

struct MovieDetailRatingsResponse: Codable {
    let Source: String
    let Value: String
}
