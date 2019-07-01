//
//  Coordinator.swift
//  Headlines
//
//  Created by Arjun P A on 25/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

/// An interface the coordinator adopts to.
protocol Coordinator: class {
    
    /// Begins the execution of the coordinator
    func start()
    
    /// A callback to denote the coordinator has finished its concern.
    var coordinatorDidFinish: ((Coordinator) -> Void)? { get set }
    
    /// The array of child coordinators.
    var childCoordinators: [Coordinator] { get set }
    
    /**
     Add a child coordinator
    
     - Parameter coordinator: The child coordinator.
    */
    func addChildCoordinator(coordinator: Coordinator)
    
    /**
     Remove a child coordinator
    
     - Parameter coordinator: The child coordinator to be removed.
    */
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
