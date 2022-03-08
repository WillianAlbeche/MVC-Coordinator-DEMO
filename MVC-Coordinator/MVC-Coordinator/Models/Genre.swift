//
//  Genre.swift
//  CBMtoW
//
//  Created by Alex Freitas on 11/07/21.
//

import Foundation

struct Genre: Decodable {
    let id: Int
    let name: String
}

struct GenreList: Decodable {
    var genres: [Genre] = []
}
