//
//  ArticleViewModel.swift
//  Headlines
//
//  Created by Arjun P A on 26/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

class ArticleViewModel {
    let title: String?
    let imageURL: URL?
    let body: String?
    let publishedDate: Date?
    
    init(article: Article) {
        self.title = article.headline
        self.body = article.body
        if let rawImageURL = article.rawImageURL {
            self.imageURL = URL(string: rawImageURL)
        } else {
            self.imageURL = nil
        }
        
        self.publishedDate = article.published
    }
}
