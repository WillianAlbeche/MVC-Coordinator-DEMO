//
//  Storyboarded.swift
//  MVC-Coordinator
//
//  Created by Alex Freitas on 10/03/2022.
//

import UIKit

protocol Storyboarded {
    static func instantiated() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiated() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
