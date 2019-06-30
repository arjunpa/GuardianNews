//
//  FavouriteListCoordinator.swift
//  Headlines
//
//  Created by Arjun P A on 30/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class FavoriteListCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private weak var rootNavigationController: UINavigationController?
    
    private lazy var favouriteArticleListViewModel: FavouriteArticleListViewModel = {
        guard let localDataManager = LocalDataManager<Article>() else {
            fatalError()
        }
        let dataProvider = FavouriteArticleListDataProvider(localDataManager: localDataManager)
        return FavouriteArticleListViewModel(dataProvider: dataProvider)
    }()
    
    init(with rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
    }
    
    func start() {
        let favouriteListViewController = FavouritesViewController(with: self.favouriteArticleListViewModel)
        let navigationController = UINavigationController(rootViewController: favouriteListViewController)
        self.rootNavigationController?.topViewController?.present(navigationController,
                                                                  animated: true,
                                                                  completion: nil)
    }
}
