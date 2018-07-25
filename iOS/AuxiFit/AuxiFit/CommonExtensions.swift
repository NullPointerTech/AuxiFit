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

extension UIButton {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.layer.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.frame = self.layer.frame
        mask.strokeColor = self.backgroundColor?.cgColor
        mask.fillColor = self.backgroundColor?.cgColor
        mask.lineWidth = 1.0
        mask.path = path.cgPath
        self.layer.mask = mask
    }

    func addRightBorder(borderColor: UIColor, borderWidth: CGFloat) {
        let border = CALayer()
        border.backgroundColor = borderColor.cgColor
        border.frame = CGRect(x: self.frame.size.width - borderWidth,y: 0, width:borderWidth, height:self.frame.size.height)
        self.layer.addSublayer(border)
    }

    func addLeftBorder(borderColor: UIColor, borderWidth: CGFloat) {
        let border = CALayer()
        border.backgroundColor = borderColor.cgColor
        border.frame = CGRect(x:0, y:0, width:borderWidth, height:self.frame.size.height)
        self.layer.addSublayer(border)
    }
}
