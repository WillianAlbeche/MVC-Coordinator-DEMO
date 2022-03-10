//
//  Coordinator.swift
//  MVC-Coordinator
//
//  Created by Alex Freitas on 10/03/2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
