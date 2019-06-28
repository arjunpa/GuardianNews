//
//  ArticleListResponse.swift
//  Headlines
//
//  Created by Arjun P A on 28/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

struct ArticleListResponse: Decodable {
    
    private enum ArticleListResponseBodyKeys: String, CodingKey {
        case response
        case results
    }
    
    private enum ArticleListResultsKeys: String, CodingKey {
        case results
    }
    
    let articles: [Article]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ArticleListResponseBodyKeys.self)
        let response = try container.nestedContainer(keyedBy: ArticleListResponseBodyKeys.self, forKey: .response)
        let articles = try response.decode([Article].self, forKey: .results)
        self.articles = articles
    }
}
