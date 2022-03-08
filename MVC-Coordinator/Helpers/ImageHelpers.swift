//
//  ImageHelpers.swift
//  CBMtoW
//
//  Created by Alex Freitas on 11/07/21.
//

import Foundation
import UIKit

struct ImageHelpers {
    static func getImageURL(path: String) -> URL {
        let baseURL = "https://image.tmdb.org/t/p/"
        let imageSize = "w500"
        let imageURL: URL = URL(string: baseURL + imageSize + path)!
        return imageURL
    }
}

extension UIImageView {
    func loadImage(withUrl url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
