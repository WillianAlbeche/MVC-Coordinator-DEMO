//
//  DCEU_Movies.swift
//  DC Movies
//
//  Created by Alex Freitas on 25/03/21.
//

import Foundation
import SwiftUI

struct DCEU_Movie: Hashable, Codable, Identifiable {
    var id: Int
    var title: String
    var year: Int
    
    var userScore: String
    var score: Double {
//        String(format: "%.1f", userScore)
        Double(userScore) ?? 0.0
    }
    
    var description: String
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}
