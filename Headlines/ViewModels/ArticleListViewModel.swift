//
//  ArticleListViewModel.swift
//  Headlines
//
//  Created by Arjun P A on 26/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

protocol ArticleListViewModelInterface {
    
    /// The view delegate.
    var viewDelegate: ArticleListViewDelegate? { get set }
    
    /// The number of articles.
    var articleCount: Int { get }
    
    /**
     Article at an index.
    
     - Parameter index: The index.
     - Returns: The article view model at the given index.
    */
    func article(at index: Int) -> ArticleViewModel
    
    
    /// Fetch articles.
    func fetchArticles()
}

protocol ArticleListViewDelegate: class {
    func updateView()
}

protocol ArticleListCoordinatorDelegate: class {
    func showFavourites()
}

class ArticleListViewModel: ArticleListViewModelInterface {
    
    weak var viewDelegate: ArticleListViewDelegate?
    
    weak var coordinatorDelegate: ArticleListCoordinatorDelegate?
    
    var articleCount: Int {
        return self.articleViewModels.count
    }
    
    private lazy var articleViewModels: [ArticleViewModel] = []
    
    private let articleRepository: ArticleListDataProviderInterface
    
    /**
     Initializes the view model with a data provider.
    
     - Parameter articleRepository: The repository or data provider.
    */
    init(articleRepository: ArticleListDataProviderInterface) {
        self.articleRepository = articleRepository
    }
    
    func article(at index: Int) -> ArticleViewModel {
        return self.articleViewModels[index]
    }
    
    func fetchArticles() {
        
        self.articleRepository.fetchArticles { result in
            switch result {
            case .success(let articles):
                self.mapViewModels(with: articles)
            case .failure:
                break
            }
            self.viewDelegate?.updateView()
        }
    }
    
    private func mapViewModels(with articles:[Article]) {
        
        let onFavouriteUpdate: ((Bool, Article) -> Void) = { [weak self] status, article in
            self?.articleRepository.updateFavourite(with: article, status: status)
        }
        
        let onShowFavourites: (() -> Void) = { [weak self] in
            self?.coordinatorDelegate?.showFavourites()
        }
        
        self.articleViewModels = articles.map({ ArticleViewModel(onFavouriteUpdate: onFavouriteUpdate,
                                                                 onShowFavourites: onShowFavourites,
                                                                 article: $0) })
    }
}
