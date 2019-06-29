//
//  NibLoadable.swift
//  Headlines
//
//  Created by Arjun P A on 29/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

protocol NibLoadable {
    static var nibName: String { get }
    static var reuseIdentifier: String { get }
}

extension NibLoadable where Self: UICollectionViewCell {
    
    static var nibName: String {
        return String(describing: Self.self)
    }
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension NibLoadable where Self: UITableViewCell {
    
    static var nibName: String {
        return String(describing: Self.self)
    }
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UICollectionViewCell: NibLoadable {}

extension UITableViewCell: NibLoadable {}
