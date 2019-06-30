//
//  FavouriteArticleListDataProvider.swift
//  Headlines
//
//  Created by Arjun P A on 30/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

protocol FavouriteArticleListDataProviderInterface {
    func fetchFavouriteArticles(with searchTerm: String?, completion: @escaping (Result<[Article], Error>) -> Void)
}

class FavouriteArticleListDataProvider: FavouriteArticleListDataProviderInterface {
    
    private static let favouriteQuery = "isFavourite = true"
    private static let favouriteQueryWithSearch = "isFavourite = true AND headline CONTAINS[c] '%@'"

    
    private let localDataManager: LocalDataManager<Article>
    
    init(localDataManager: LocalDataManager<Article>) {
        self.localDataManager = localDataManager
    }
    
    func fetchFavouriteArticles(with searchTerm: String?, completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let searchTerm = searchTerm, !searchTerm.trimmingCharacters(in: .newlines).isEmpty else {
            completion(.success(self.localDataManager.read(with: type(of: self).favouriteQuery) ?? []))
            return
        }
        completion(.success(self.localDataManager.read(with: String(format: type(of: self).favouriteQueryWithSearch, searchTerm)) ?? []))
    }
}
