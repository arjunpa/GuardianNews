//
//  FavouriteListCoordinator.swift
//  Headlines
//
//  Created by Arjun P A on 30/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

final class FavoriteListCoordinator: Coordinator {
    
    var coordinatorDidFinish: ((Coordinator) -> Void)?
    
    var childCoordinators: [Coordinator] = []
    
    private weak var sourceViewController: UIViewController?
    
    private weak var rootViewController: UIViewController?
    
    private lazy var favouriteArticleListViewModel: FavouriteArticleListViewModel = {
        guard let localDataManager = LocalDataManager<Article>() else {
            fatalError()
        }
        let dataProvider = FavouriteArticleListDataProvider(localDataManager: localDataManager)
        return FavouriteArticleListViewModel(dataProvider: dataProvider)
    }()
    
    init(with sourceViewController: UIViewController) {
        self.sourceViewController = sourceViewController
    }
    
    func start() {
        self.favouriteArticleListViewModel.coordinatorDelegate = self
        let favouriteListViewController = FavouritesViewController(with: self.favouriteArticleListViewModel)
        let navigationController = UINavigationController(rootViewController: favouriteListViewController)
        self.rootViewController = navigationController
        self.sourceViewController?.present(navigationController, animated: true, completion: nil)
    }
}

extension FavoriteListCoordinator: FavoriteArticleListCoordinatorDelegate {
    
    func didFinish() {
        self.rootViewController?.dismiss(animated: true, completion: nil)
        self.coordinatorDidFinish?(self)
    }
}
