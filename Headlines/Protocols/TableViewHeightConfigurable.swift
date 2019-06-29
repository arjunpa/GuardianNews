//
//  TableViewHeightConfigurable.swift
//  Headlines
//
//  Created by Arjun P A on 29/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import CoreGraphics

protocol TableViewHeightConfigurable {
    var rowHeight: CGFloat { get }
    var footerHeight: CGFloat { get }
    func estimatedRowHeight(forRow row: Int, targetSize: CGSize) -> CGFloat
    func estimatedFooterHeight(for section: Int, targetSize: CGSize) -> CGFloat
}
