//
//  AppCoordinator.swift
//  Headlines
//
//  Created by Arjun P A on 25/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

protocol AppCoordinator: Coordinator {
    var rootViewController: UIViewController? { get }
    var navigationController: UINavigationController? { get }
}

final class MainAppCoordinator: AppCoordinator {
    
    var coordinatorDidFinish: ((Coordinator) -> Void)?
    
    var rootViewController: UIViewController? {
        return self.navigationController
    }
    
    var navigationController: UINavigationController? {
        return self.window.rootViewController as? UINavigationController
    }
    
    var childCoordinators: [Coordinator] = []

    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        self.runMainAppFlow()
    }
    
    private func runMainAppFlow() {
        let navigationController = UINavigationController()
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
        let articleCoordinator = MainArticleCoordinator(rootViewController: navigationController)
        self.addChildCoordinator(coordinator: articleCoordinator)
        articleCoordinator.start()
    }
}
