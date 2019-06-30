//
//  FavouriteArticleListViewModel.swift
//  Headlines
//
//  Created by Arjun P A on 30/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

protocol FavouriteArticleListViewModelInterface {
    var viewDelegate: FavouriteArticleListViewDelegate? { get set }
    var numberOfArticles: Int { get }
    func fetchFavouriteArticles(with searchTerm: String?)
    func favouriteArticle(at index: Int) -> FavouriteArticleViewModel
}

protocol FavouriteArticleListViewDelegate: class {
    func updateView()
}

class FavouriteArticleListViewModel: FavouriteArticleListViewModelInterface {

    private let dataProvider: FavouriteArticleListDataProviderInterface
    private lazy var favouriteArticleViewModels: [FavouriteArticleViewModel] = []
    
    weak var viewDelegate: FavouriteArticleListViewDelegate?
    
    var numberOfArticles: Int {
        return self.favouriteArticleViewModels.count
    }
    
    init(dataProvider: FavouriteArticleListDataProviderInterface) {
        self.dataProvider = dataProvider
    }
    
    func fetchFavouriteArticles(with searchTerm: String?) {
        self.dataProvider.fetchFavouriteArticles(with: searchTerm) { result in
            switch result {
            case .success(let articles):
                self.favouriteArticleViewModels = articles.map({ FavouriteArticleViewModel(article: $0) })
            case .failure:
                break
            }
            self.viewDelegate?.updateView()
        }
    }
    
    func favouriteArticle(at index: Int) -> FavouriteArticleViewModel {
        return self.favouriteArticleViewModels[index]
    }
}
