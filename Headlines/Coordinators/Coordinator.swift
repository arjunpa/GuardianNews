//
//  Coordinator.swift
//  Headlines
//
//  Created by Arjun P A on 25/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    func addChildCoordinator(coordinator: Coordinator)
    func removeChildCoordinator(coordinator: Coordinator)
}

extension Coordinator {
    
    func addChildCoordinator(coordinator: Coordinator) {
        self.childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(coordinator: Coordinator) {
        self.childCoordinators.removeAll(where: { $0 === coordinator })
    }
}
