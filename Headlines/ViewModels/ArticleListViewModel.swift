//
//  ArticleListViewModel.swift
//  Headlines
//
//  Created by Arjun P A on 26/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

protocol ArticleListViewModelInterface {
    var articleCount: Int { get }
    func article(at index: Int) -> ArticleViewModel
    func fetchArticles(completion: @escaping (Result<[ArticleViewModel], Error>) -> Void)
}

class ArticleListViewModel: ArticleListViewModelInterface {
    
    var articleCount: Int {
        return self.articleViewModels.count
    }
    
    private lazy var articleViewModels: [ArticleViewModel] = []
    
    private let articleRepository: ArticleRepository
    
    init(articleRepository: ArticleRepository) {
        self.articleRepository = articleRepository
    }
    
    func article(at index: Int) -> ArticleViewModel {
        return self.articleViewModels[index]
    }
    
    func fetchArticles(completion: @escaping (Result<[ArticleViewModel], Error>) -> Void) {
        
        self.articleRepository.fetchArticles { result in
            switch result {
            case .success(let articles):
                self.articleViewModels = articles.map({ ArticleViewModel(article: $0) })
                completion(.success(self.articleViewModels))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
