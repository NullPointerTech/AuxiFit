//
//  CommonExtensions.swift
//  AuxiFit
//
//  Created by Anjandeep Sahni on 18/07/18.
//  Copyright © 2018 Null Pointer Tech. All rights reserved.
//

import UIKit

// Extension to easily setup constraints for collection view cells.
extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDict = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDict[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict))
    }
}
