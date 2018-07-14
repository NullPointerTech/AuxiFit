//
//  WorkoutsVCHelper.swift
//  AuxiFit
//
//  Created by Anjandeep Sahni on 15/07/18.
//  Copyright © 2018 Null Pointer Tech. All rights reserved.
//

import UIKit

struct WorkoutCellItem {
    var name: String
    var lastCompleted: String
    var nextWorkout: String

    init(name: String = "My Workout",
        lastCompleted: String = "Never",
        nextWorkout: String = "None") {
        self.name = name
        self.lastCompleted = lastCompleted
        self.nextWorkout = nextWorkout
    }
}

class WorkoutCell: UICollectionViewCell {
    var workoutCellItem: WorkoutCellItem? {
        didSet {
            // Add workout name. Since this is first item, we use mutable.
            let workoutName = NSMutableAttributedString(string: (workoutCellItem?.name)!, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18)])
            let attributedText = workoutName
            // Add last completed date.
            let lastCompString = "\nLast Completed: " + (workoutCellItem?.lastCompleted)!
            let workoutLastComp = NSAttributedString(string: lastCompString, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.gray])
            attributedText.append(workoutLastComp)
            // Add next workout details.
            let nextWorkoutString = "\nNext Workout: " + (workoutCellItem?.nextWorkout)!
            let workoutNextDet = NSAttributedString(string: nextWorkoutString, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.gray])
            attributedText.append(workoutNextDet)
            // Set line spacing.
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
            //Finally, update workoutInfoLabel and return.
            workoutInfoLabel.attributedText = attributedText
        }
    }

    // Create workout info label.
    let workoutInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Setup workout cell views on init.
        setupCellViews()
    }

    // This is required by compiler.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCellViews() {
        backgroundColor = UIColor.white

        // Add to subview hierarchy.
        addSubview(workoutInfoLabel)

        // Put on screen using constraints. 8 pixels from left.
        addConstraintsWithFormat(format: "H:|-8-[v0]|", views: workoutInfoLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: workoutInfoLabel)
    }
}

// Extension to easily setup constraints for workout cells.
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
