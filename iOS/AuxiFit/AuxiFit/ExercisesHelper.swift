//
//  ExercisesHelper.swift
//  AuxiFit
//
//  Created by Anjandeep Sahni on 30/08/18.
//  Copyright © 2018 Null Pointer Tech. All rights reserved.
//

import UIKit

class ExerciseCell: UICollectionViewCell {
    var exerciseCellItem: String? {
        didSet {
            //Add exercise name to cell label.
            exerciseLabel.text = exerciseCellItem
        }
    }

    // Create exercise label.
    let exerciseLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
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
        addSubview(exerciseLabel)

        // Put on screen using constraints. 8 pixels from left.
        addConstraintsWithFormat(format: "H:|-8-[v0]|", views: exerciseLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: exerciseLabel)
    }
}
