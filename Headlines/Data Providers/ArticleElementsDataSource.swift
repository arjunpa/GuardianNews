//
//  ArticleElementsDataSource.swift
//  Headlines
//
//  Created by Arjun P A on 29/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

final class ArticleElementsDataSource: NSObject, TableViewConfigurable {
    
    internal lazy var reuseIdentifiersForHeaderFooters: [String] = []
    
    internal lazy var reuseIdentifiersForCell: [String] = []
    
    var articleViewModel: ArticleViewModel?
}

extension ArticleElementsDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleViewModel?.elements.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return type(of: self).defaultHeaderView(for: tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return type(of: self).defaultHeightForHeaderView
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
        return self.articleViewModel?.estimatedRowHeight(forRow: indexPath.row, targetSize: tableView.bounds.size) ?? 0.001
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return self.articleViewModel?.estimatedFooterHeight(for: section, targetSize: tableView.bounds.size) ?? 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let articleViewModel = self.articleViewModel,
              let articleFooterView = self.dequeueHeaderFooter(with: tableView, reuseIdentifier: ArticleFooterView.reuseIdentifier, nibName: ArticleFooterView.nibName) as? ArticleFooterView
            else { return nil }
        articleFooterView.isFavoritSelected = self.articleViewModel?.isFavorite ?? false
        articleFooterView.didInteractWithFavorite = { status in
            articleViewModel.onFavoriteUpdate?(status)
        }
        return articleFooterView
    }
}
