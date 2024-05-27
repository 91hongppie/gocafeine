//
//  MovieDetail.swift
//  MovieWalk
//
//  Created by Kyuhong Jo on 5/27/24.
//

import Foundation

struct MovieDetail {
    let Title: String
    let Year: String
    let Released: String
    let Runtime: String
    let Director: String
    let Actors: String
    let Poster: String
    let Plot: String
    let Ratings: String
    let RottenTomatoes: String
    
    init(dictionary: [String: Any]) {
        self.Title = dictionary["Title"] as? String ?? ""
        self.Year = dictionary["Year"] as? String ?? ""
        self.Released = dictionary["Released"] as? String ?? ""
        self.Runtime = dictionary["Runtime"] as? String ?? ""
        self.Director = dictionary["Director"] as? String ?? ""
        self.Actors = dictionary["Actors"] as? String ?? ""
        self.Poster = dictionary["Poster"] as? String ?? ""
        self.Plot = dictionary["Plot"] as? String ?? ""
        self.Ratings = dictionary["Ratings"] as? String ?? ""
        self.RottenTomatoes = dictionary["RottenTomatoes"] as? String ?? ""
    }
}
