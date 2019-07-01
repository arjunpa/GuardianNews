//
//  TableViewConfigurable.swit
//  Headlines
//
//  Created by Arjun P A on 29/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

protocol TableViewConfigurable: class {
    
    /// The reuse identifiers for the cell.
    var reuseIdentifiersForCell: [String] { set get }
    
    /// The reuse identifiers for the headers and footers of the table view.
    var reuseIdentifiersForHeaderFooters: [String] { set get }
}

extension TableViewConfigurable {
    
    private static var defaultHeaderViewReuseIdentifier: String {
        return "DefaultHeaderView"
    }
    
    /// The default height for the header or footer view.
    static var defaultHeightForHeaderFooterView: CGFloat {
        return 0.01
    }
    
    static func defaultHeaderView(for tableView: UITableView) -> UITableViewHeaderFooterView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: Self.defaultHeaderViewReuseIdentifier)
    }
    
    /**
     Dequeues a cell associated with the given tableview and ensures the cell is registered with the associated nib before performing the dequeue.
    
     - Parameters:
       - tableView: The table view.
       - reuseIdentifier: The reuse identifier.
       - nibName: The nib name associated with the cell.
     - Returns: A table view cell.
    */
    func dequeueCell(with tableView: UITableView, reuseIdentifier: String, nibName: String) -> UITableViewCell? {
        if !self.reuseIdentifiersForCell.contains(reuseIdentifier) {
            self.reuseIdentifiersForCell.append(reuseIdentifier)
            tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        }
        return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
    }
    
    /**
      Dequeues a header footer view associated with the given tableview and ensures the view is registered with the associated nib before performing the dequeue.
    
     - Parameters:
       - tableView: The table view
       - reuseIdentifier: The reuse identifier.
       - nibName: The nib name associated with the view
     - Returns: A table header footer view.
    */
    func dequeueHeaderFooter(with tableView: UITableView, reuseIdentifier: String, nibName: String) -> UITableViewHeaderFooterView? {
        if !self.reuseIdentifiersForHeaderFooters.contains(reuseIdentifier) {
            self.reuseIdentifiersForHeaderFooters.append(reuseIdentifier)
            tableView.register(UINib(nibName: nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: reuseIdentifier)
        }
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier)
    }
}

