//
//  ArticleCoordinator.swift
//  Headlines
//
//  Created by Arjun P A on 25/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

final class MainArticleCoordinator: Coordinator {
    
    var coordinatorDidFinish: ((Coordinator) -> Void)?
    
    var childCoordinators: [Coordinator] = []
    
    weak var navigationController: UINavigationController?
    
    private weak var rootViewController: UIViewController?
    
    private lazy var articleListViewModel: ArticleListViewModel = {
        guard let localDataManager = LocalDataManager<Article>() else {
            fatalError()
        }
        let remoteDataManager = RemoteDataManager()
        let articleListClient = ArticleListService(dataManager: remoteDataManager)
        let articleListDataProvider = ArticleListDataProvider(articleClient: articleListClient,
                                                              localDataManager: localDataManager)
        
       return ArticleListViewModel(articleRepository: articleListDataProvider)
    }()
    
    /// Initialize the coordinator with a root navigation controller.
    ///
    /// - Parameter rootViewController: The root navigation controller/
    init(rootViewController: UINavigationController) {
        self.navigationController = rootViewController
    }
    
    func start() {
        self.articleListViewModel.coordinatorDelegate = self
        let articleViewController = ArticleViewController(with: self.articleListViewModel)
        self.rootViewController = articleViewController
        self.navigationController?.pushViewController(articleViewController, animated: false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension MainArticleCoordinator: ArticleListCoordinatorDelegate {
    
    internal func showFavourites() {
        guard let rootViewController = self.rootViewController else { return }
        let favoriteArticleListCoordinator = FavoriteListCoordinator(with: rootViewController)
        favoriteArticleListCoordinator.coordinatorDidFinish = { [weak self] coordinator in
            self?.removeChildCoordinator(coordinator: coordinator)
        }
        
        self.addChildCoordinator(coordinator: favoriteArticleListCoordinator)
        favoriteArticleListCoordinator.start()
    }
}
