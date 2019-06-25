//
//  ArticleCoordinator.swift
//  Headlines
//
//  Created by Arjun P A on 25/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

protocol ArticleCoordinator: Coordinator {}

class MainArticleCoordinator: ArticleCoordinator {
    
    var childCoordinators: [Coordinator] = []
    
    weak var navigationController: UINavigationController?
    
    init(rootViewController: UINavigationController) {
        self.navigationController = rootViewController
    }
    
    func start() {
        let articleViewController = ArticleViewController()
        self.navigationController?.pushViewController(articleViewController, animated: false)
    }
}
