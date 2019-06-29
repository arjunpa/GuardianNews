//
//  CellConfigurable.swift
//  Headlines
//
//  Created by Arjun P A on 29/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

protocol CellConfigurable: class {
    var reuseIdentifiers: [String] { set get }
}

extension CellConfigurable {
    
    func dequeueCell(with tableView: UITableView, reuseIdentifier: String, nibName: String) -> UITableViewCell? {
        if !self.reuseIdentifiers.contains(reuseIdentifier) {
            self.reuseIdentifiers.append(reuseIdentifier)
            tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        }
        return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
    }
}

