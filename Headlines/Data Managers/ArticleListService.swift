//
//  ArticleService.swift
//  Headlines
//
//  Created by Arjun P A on 26/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

class ArticleListService {
    
    private static let APIKey = "enj8pstqu5yat6yesfsdmd39"
    
    private static let urlString = "http://content.guardianapis.com/search?q=fintech&show-fields=main,body&api-key=\(APIKey)"
    
    private let dataManager: RemoteDataManager
    
    init(dataManager: RemoteDataManager) {
        self.dataManager = dataManager
    }
    
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = URL(string: type(of: self).urlString) else { return }
        self.dataManager.request(url: url) { result in
            switch result {
            case .success(let data):
                guard let articleListResponse = try? JSONDecoder().decode(ArticleListResponse.self, from: data) else { return }
                completion(.success(articleListResponse.articles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
