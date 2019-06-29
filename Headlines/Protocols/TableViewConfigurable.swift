//
//  TableViewConfigurable.swit
//  Headlines
//
//  Created by Arjun P A on 29/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

protocol TableViewConfigurable: class {
    var reuseIdentifiersForCell: [String] { set get }
    var reuseIdentifiersForHeaderFooters: [String] { set get }
}

extension TableViewConfigurable {
    
    private static var defaultHeaderViewReuseIdentifier: String {
        return "DefaultHeaderView"
    }
    
    static var defaultHeightForHeaderView: CGFloat {
        return 0.01
    }
    
    static func defaultHeaderView(for tableView: UITableView) -> UITableViewHeaderFooterView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: Self.defaultHeaderViewReuseIdentifier)
    }
    
    func dequeueCell(with tableView: UITableView, reuseIdentifier: String, nibName: String) -> UITableViewCell? {
        if !self.reuseIdentifiersForCell.contains(reuseIdentifier) {
            self.reuseIdentifiersForCell.append(reuseIdentifier)
            tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        }
        return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
    }
    
    func dequeueHeaderFooter(with tableView: UITableView, reuseIdentifier: String, nibName: String) -> UITableViewHeaderFooterView? {
        if !self.reuseIdentifiersForHeaderFooters.contains(reuseIdentifier) {
            self.reuseIdentifiersForHeaderFooters.append(reuseIdentifier)
            tableView.register(UINib(nibName: nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: reuseIdentifier)
        }
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier)
    }
}

