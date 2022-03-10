//
//  MainCoordinator.swift
//  MVC-Coordinator
//
//  Created by Alex Freitas on 10/03/2022.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinator = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        
        let vc = ViewController.instantiated()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
