//
//  FavouriteArticleViewModel.swift
//  Headlines
//
//  Created by Arjun P A on 30/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

final class FavouriteArticleViewModel {
    
    private static let dateFormat = "dd/MM/yyyy"
    
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter
    }()
    
    private let article: Article
    
    let headline: String?
    let date: String?
    let imageURL: URL?
    
    init(article: Article) {
        self.article = article
        self.headline = article.headline
        self.date = type(of: self).formatDate(with: article.published)
        if let rawImageURL = article.rawImageURL {
            self.imageURL = URL(string: rawImageURL)
        } else {
            self.imageURL = nil
        }
    }
    
    private static func formatDate(with date: Date?) -> String? {
        guard let date = date else { return nil }
        return self.dateFormatter.string(from: date)
    }
}
