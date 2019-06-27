//
//  ArticleCoordinator.swift
//  Headlines
//
//  Created by Arjun P A on 25/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

protocol ArticleListCoordinator: Coordinator {}

final class MainArticleCoordinator: ArticleListCoordinator {
    
    var childCoordinators: [Coordinator] = []
    
    weak var navigationController: UINavigationController?
    
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
    
    init(rootViewController: UINavigationController) {
        self.navigationController = rootViewController
    }
    
    func start() {
        let articleViewController = ArticleViewController(with: self.articleListViewModel)
        self.navigationController?.pushViewController(articleViewController, animated: false)
    }
}