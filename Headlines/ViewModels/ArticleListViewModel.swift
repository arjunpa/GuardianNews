//
//  ArticleListViewModel.swift
//  Headlines
//
//  Created by Arjun P A on 26/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

protocol ArticleListViewModelInterface {
    var viewDelegate: ArticleListViewDelegate? { get set }
    var articleCount: Int { get }
    func article(at index: Int) -> ArticleViewModel
    func fetchArticles()
}

protocol ArticleListViewDelegate: class {
    func updateView()
}

class ArticleListViewModel: ArticleListViewModelInterface {
    
    weak var viewDelegate: ArticleListViewDelegate?
    
    var articleCount: Int {
        return self.articleViewModels.count
    }
    
    private lazy var articleViewModels: [ArticleViewModel] = []
    
    private let articleRepository: ArticleListDataProviderInterface
    
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
        
        let onFavouriteUpdate: ((Bool, Article) -> Void) = { status, article in
            self.articleRepository.updateFavourite(with: article, status: status)
        }
        
        let onShowFavourites: (() -> Void) = {
            
        }
        
        self.articleViewModels = articles.map({ ArticleViewModel(onFavouriteUpdate: onFavouriteUpdate,
                                                                 onShowFavourites: onShowFavourites,
                                                                 article: $0) })
    }
}
