//
//  ModelData.swift
//  DC Movies
//
//  Created by Alex Freitas on 25/03/21.
//

import Foundation

var movies: [DCEU_Movie] = load("DCEU_Movies.json")

var popularMovies: [DCEU_Movie] = []

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

//func topMovies(movies: [DCEU_Movie]) {
//    for movie in movies {
//        if movie.userScore >= 7.0 {
//            popularMovies.append(movie)
//        }
//    }
//}
