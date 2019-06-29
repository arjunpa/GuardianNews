//
//  ArticleViewModel.swift
//  Headlines
//
//  Created by Arjun P A on 26/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

final class ArticleViewModel {
    
    enum ArticleViewElements {
        case headline(ArticleHeadlineElementViewModel)
        case body(ArticleTextElementViewModel)
    }

    lazy var elements: [ArticleViewElements] = {
        var elements = Array<ArticleViewElements>()
        elements.reserveCapacity(2)
        return elements
    }()
    
    init(article: Article) {
      if let headline = article.headline,
         let rawImageURL = article.rawImageURL,
         let imageURL = URL(string: rawImageURL) {
            self.elements.append(.headline(ArticleHeadlineElementViewModel(headline: headline,
                                                                           imageURL: imageURL)))
        }
        if let articleBody = article.body {
            self.elements.append(.body(ArticleTextElementViewModel(text: articleBody)))
        }
    }
}

extension ArticleViewModel: TableViewHeightConfigurable {
    
    private static let estimatedRowHeightText: CGFloat = 1750.00
    private static let estimatedFooterHeight: CGFloat = 30.0
    
    var rowHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
    var footerHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
    func estimatedRowHeight(forRow row: Int, targetSize: CGSize) -> CGFloat {
        switch row {
        case 0:
            return ceil(4/3 * targetSize.width)
        
        case 1:
            return type(of: self).estimatedRowHeightText
        default:
            return type(of: self).estimatedRowHeightText
        }
    }
    
    func estimatedFooterHeight(for section: Int, targetSize: CGSize) -> CGFloat {
        return type(of: self).estimatedFooterHeight
    }
}
