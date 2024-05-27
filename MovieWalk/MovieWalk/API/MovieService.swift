//
//  Service.swift
//  MovieWalk
//
//  Created by Kyuhong Jo on 5/27/24.
//

import Foundation

struct MovieService {
    static let shared = MovieService()
    
    func fetchMovieList(withSearch searchText: String, page: Int, completion: @escaping(([Movie]?, Error?) -> Void)) -> Void {
        guard let API_KEY = Environment.movieApiKey else { return }
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(API_KEY)&s=\(searchText)&page=\(page)&type=movie") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                print("DEBUG: failed to get movies")
                completion(nil, error)
            }
            guard let data = data else { return }
            
            guard let json = try? JSONDecoder().decode(MovieListResponse.self, from: data) else { return }
            var movies: [Movie] = []
            for movie in json.Search {
                let dictionary = [
                    "title": movie.Title,
                    "year": movie.Year,
                    "imdbID": movie.imdbID,
                    "poster": movie.Poster,
                ]
                movies.append(Movie(dictionary: dictionary))
            }
            completion(movies, nil)
        }.resume()
    }
    
    func fetchMovieDetail(withId id: String, completion: @escaping((MovieDetail?, Error?) -> Void)) -> Void {
        guard let API_KEY = Environment.movieApiKey else { return }
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(API_KEY)&i=\(id)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else { return }
            
            guard let json = try? JSONDecoder().decode(MovieDetailResponse.self, from: data) else { return }
            var Ratings = ""
            var RottenTomatoes = ""
            for rating in json.Ratings {
                if rating.Source == "Internet Movie Database" {
                    Ratings = rating.Value
                } else if rating.Source == "Rotten Tomatoes" {
                    RottenTomatoes = rating.Value
                }
            }
            let dictionary = [
                "Title": json.Title,
                "Year": json.Year,
                "Released": json.Released,
                "Runtime": json.Runtime,
                "Director": json.Director,
                "Actors":json.Actors,
                "Poster":json.Poster,
                "Plot":json.Plot,
                "Ratings": Ratings,
                "RottenTomatoes": RottenTomatoes
            ]

            let movieDetail = MovieDetail(dictionary: dictionary)
            
            completion(movieDetail, nil)
        }.resume()
    }
}
