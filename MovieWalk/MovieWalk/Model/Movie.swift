//
//  Movie.swift
//  MovieWalk
//
//  Created by Kyuhong Jo on 5/27/24.
//

import Foundation

struct Movie {
    let title: String
    let year: String
    let imdbID: String
    let poster: String
    
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.year = dictionary["year"] as? String ?? ""
        self.imdbID = dictionary["imdbID"] as? String ?? ""
        self.poster = dictionary["poster"] as? String ?? ""
    }
}
