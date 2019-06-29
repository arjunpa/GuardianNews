//
//  ArticleRepsitory.swift
//  Headlines
//
//  Created by Arjun P A on 26/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

protocol ArticleListDataProviderInterface {
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void)
    func updateFavorite(with article: Article, status: Bool)
}

final class ArticleListDataProvider: ArticleListDataProviderInterface  {
    
    private let articleClient: ArticleListService
    private let localDataManager: LocalDataManager<Article>
    
    init(articleClient: ArticleListService, localDataManager: LocalDataManager<Article>) {
        self.articleClient = articleClient
        self.localDataManager = localDataManager
    }
    
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        self.articleClient.fetchArticles { result in
            switch result {
            case .success(let articles):
                
                //ToDo: If the article does get updated, this might create problems as the favorite property will get reset. So, partial update might be better in this case.
                
                //self.localDataManager.add(update: true, objects: articles)
                self.updateLocal(with: articles)
                completion(.success(self.localDataManager.read() ?? articles))
            case .failure(let error):
                if let articles = self.localDataManager.read() {
                    completion(.success(articles))
                }
                completion(.failure(error))
            }
        }
    }
    
    func updateFavorite(with article: Article, status: Bool) {
        self.localDataManager.update {
            article.isFavorite = status
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
