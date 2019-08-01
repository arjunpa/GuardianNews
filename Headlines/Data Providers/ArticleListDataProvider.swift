//
//  ArticleRepsitory.swift
//  Headlines
//
//  Created by Arjun P A on 26/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

/// A common interface the article data providers should conform to.
protocol ArticleListDataProviderInterface {
    
    /**
     Fetch articles from remote or local.
    
     - Parameter completion: The completion block that is executed with the result.
    */
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void)
    
    /**
     Update the favorite status of the article
    
     - Parameters:
       - article: The article.
       - status: A boolean indicating whether the article was added as a favourite or removed as a favourite.
    */
    func updateFavourite(with article: Article, status: Bool)
}

/// A data provider for the articles.
final class ArticleListDataProvider: ArticleListDataProviderInterface  {
    
    private let articleClient: ArticleListService
    private let localDataManager: LocalDataManager<Article>
    
    /**
     Initializes the data provider with a service client and a local data manager.
    
     - Parameters:
       - articleClient: The service client
       - localDataManager: The local data manager.
    */
    init(articleClient: ArticleListService, localDataManager: LocalDataManager<Article>) {
        self.articleClient = articleClient
        self.localDataManager = localDataManager
    }
    
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        self.articleClient.fetchArticles { [weak self] result in
            switch result {
            case .success(let articles):
                
                self?.updateLocal(with: articles)
                completion(.success(self?.localDataManager.read() ?? articles))
            case .failure(let error):
                if let articles = self?.localDataManager.read() {
                    completion(.success(articles))
                }
                completion(.failure(error))
            }
        }
    }
    
    func updateFavourite(with article: Article, status: Bool) {
        self.localDataManager.update {
            article.isFavourite = status
        }
    }
    
    private func updateLocal(with articles:[Article]) {
        articles.forEach { article in
            self.localDataManager.create(update: true, value: [
                Article.MemberKeys.id.rawValue: article.id,
                Article.MemberKeys.headline.rawValue: article.headline as Any,
                Article.MemberKeys.body.rawValue: article.body as Any,
                Article.MemberKeys.published.rawValue: article.published as Any,
                Article.MemberKeys.rawImageURL.rawValue: article.rawImageURL as Any
            ])
        }
    }
}
