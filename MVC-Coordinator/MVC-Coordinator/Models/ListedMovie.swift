//
//  ListedMovie.swift
//  CBMtoW
//
//  Created by Alex Freitas on 10/07/21.
//

import Foundation

struct ListedMovie: Decodable {
    let id: Int
    let title: String
    let posterPath: String
    let overview: String
    let voteAverage: Double
    let releaseDate: String
    let backdropPath: String
    var genreIds: [Int] = []

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
    }
}

struct MovieList: Decodable {
    var page: Int = 0
    var results: [ListedMovie] = []
    var totalPages: Int = 0
    var totalResults: Int = 0

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
