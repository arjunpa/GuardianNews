//
//  ArticleRepsitory.swift
//  Headlines
//
//  Created by Arjun P A on 26/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

final class ArticleRepository {
    
    private let articleClient: ArticleService
    private let localDataManager: LocalDataManager<Article>
    
    init(aricleClient: ArticleService, localDataManager: LocalDataManager<Article>) {
        self.articleClient = aricleClient
        self.localDataManager = localDataManager
    }
    
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        self.articleClient.fetchArticles { result in
            switch result {
            case .success(let articles):
                
                //ToDo: If the article does get updated, this might create problems as the favorite property will get reset. So, partial update might be better in this case.
                self.localDataManager.add(objects: articles)
                completion(.success(self.localDataManager.read() ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
