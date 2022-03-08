//
//  MockedData.swift
//  CBMtoW
//
//  Created by Alex Freitas on 30/06/21.
//

import Foundation

struct Movie: Decodable {
    var genres: [Genre] = []
    var id: Int
    var overview: String
    var releaseDate: String
    var runtime: Int
    var tagline: String
    var title: String
    var voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case genres
        case id
        case overview
        case releaseDate = "release_date"
        case runtime
        case tagline
        case title
        case voteAverage = "vote_average"
    }
}
