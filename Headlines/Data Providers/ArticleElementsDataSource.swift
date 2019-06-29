//
//  ArticleElementsDataSource.swift
//  Headlines
//
//  Created by Arjun P A on 29/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

final class ArticleElementsDataSource: NSObject, CellConfigurable {
    
    internal lazy var reuseIdentifiers: [String] = []
    
    var articleViewModel: ArticleViewModel?
}

extension ArticleElementsDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleViewModel?.elements.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let element = self.articleViewModel?.elements[indexPath.item],
              let cell: UITableViewCell = {
                switch element {
                case .headline(let headlineViewModel):
                    let headlineCell = self.dequeueCell(with: tableView,
                                            reuseIdentifier: ArticleElementHeadlineImageCell.reuseIdentifier,
                                            nibName: ArticleElementHeadlineImageCell.nibName) as? ArticleElementHeadlineImageCell
                    headlineCell?.configure(with: headlineViewModel)
                    return headlineCell
                case .body(let textViewModel):
                    let textCell = self.dequeueCell(with: tableView,
                                            reuseIdentifier: ArticleElementTextCell.reuseIdentifier,
                                            nibName: ArticleElementTextCell.nibName) as? ArticleElementTextCell
                    textCell?.configure(with: textViewModel)
                    return textCell
                }
            } ()
            else { return UITableViewCell() }
        return cell
    }
}

extension ArticleElementsDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.articleViewModel?.estimatedRowHeight(forRow: indexPath.row, targetSize: tableView.bounds.size) ?? 1.0
    }
}
