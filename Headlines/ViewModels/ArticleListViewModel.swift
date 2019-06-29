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
    func updateFavorite(for article: ArticleViewModel, with status: Bool)
}

protocol ArticleListViewDelegate: class {
    func updateView()
}

class ArticleListViewModel: ArticleListViewModelInterface {
    
    func updateFavorite(for articleViewModel: ArticleViewModel, with status: Bool) {
        self.articleRepository.updateFavorite(with: articleViewModel.article,
                                              status: status)
    }
    
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
                self.articleViewModels = articles.map({ ArticleViewModel(article: $0) })
            case .failure:
                break
            }
            self.viewDelegate?.updateView()
        }
    }
}
