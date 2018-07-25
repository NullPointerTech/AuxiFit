//
//  CreateWorkoutHelper.swift
//  AuxiFit
//
//  Created by Anjandeep Sahni on 18/07/18.
//  Copyright © 2018 Null Pointer Tech. All rights reserved.
//

import UIKit

class CreateWorkoutCellItem {
    var title: String
    var type: String
    var details: String

    init(title: String, type: String, details: String)
    {
        self.title = title
        self.type = type
        self.details = details
    }
}

class CreateWorkoutCell: UICollectionViewCell {

    // workoutName text field dimensions.
    let workoutNameFieldHeight = CGFloat(40.0)
    // workoutDescription text field dimensions.
    let workoutDescriptionFieldHeight = CGFloat(115.0)
    // addDay, addSet, addExercise button dimensions. NOTE: 28 = 2*headerPixelSpace
    let workoutControlButtonsHeight = CGFloat(30.0)
    let workoutControlButtonsWidth = CGFloat((UIScreen.main.bounds.width - 28)/3)
    // total number of subviews in header.
    let headerSubViewCount = CGFloat(3.0)
    // pixel spacing between each subview.
    let headerPixelSpace = CGFloat(14.0)
    // createWorkoutCellInfoLabel dimensions.
    static var createWorkoutCellInfoLabelHeight = CGFloat(65.0)

    // Setup cell parameters.
    var createWorkoutCellItem: CreateWorkoutCellItem? {
        didSet {
            // Add cell title.Since this is first item, we use mutable.
            let cellTitle = NSMutableAttributedString(string: (createWorkoutCellItem?.title)! + "\n", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)])
            let attributedText = cellTitle
            // Add cell type.
            let cellType = (createWorkoutCellItem?.type)! + "\n"
            attributedText.append(NSAttributedString(string: cellType, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.gray]))
            // Add cell details.
            let cellDetails = (createWorkoutCellItem?.details)!
            attributedText.append(NSAttributedString(string: cellDetails, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.gray]))
            // Set line spacing.
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 2
            paragraphStyle.firstLineHeadIndent = 8
            paragraphStyle.headIndent = 8
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
            //Finally, update workoutInfoLabel and return.
            createWorkoutCellInfoLabel.attributedText = attributedText
        }
    }

    // Create workout name text field.
    var workoutName: UITextField {
        get {
            let textWidth = UIScreen.main.bounds.width
            let textField = UITextField(frame: CGRect(x: 0, y: 0, width: textWidth, height:  workoutNameFieldHeight))
            textField.borderStyle = UITextBorderStyle.roundedRect
            textField.placeholder = "Workout Name"
            textField.font = UIFont.systemFont(ofSize: 16)
            textField.backgroundColor = UIColor.white
            return textField
        }
    }

    // Create workout description text field.
    var workoutDescription: UITextView {
        get {
            let textWidth = UIScreen.main.bounds.width
            let textView = UITextView(frame: CGRect(x: 0, y: 0, width: textWidth, height:  workoutDescriptionFieldHeight))
            // FIXME: Make sure this placeholder vanishes in textViewDidBeginEditing.
            textView.text = "Workout Description"
            // FIXME: Make sure this placeholder color matches textField place holder color.
            textView.textColor = UIColor.lightGray
            textView.layer.cornerRadius = 4
            textView.font = UIFont.systemFont(ofSize: 16)
            textView.backgroundColor = UIColor.white
            return textView
        }
    }

    var addDay: UIButton {
        get {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: workoutControlButtonsWidth, height: workoutControlButtonsHeight))
            button.setTitle("+Day", for: .normal)
            button.backgroundColor = UIColor.darkGray
            button.tintColor = UIColor.white
            button.roundCorners([.topLeft, .bottomLeft], radius: 7)
            button.addRightBorder(borderColor: UIColor.white, borderWidth: 3)
            return button
        }
    }

    var addSet: UIButton {
        get {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: workoutControlButtonsWidth, height: workoutControlButtonsHeight))
            button.setTitle("+Set", for: .normal)
            button.backgroundColor = UIColor.darkGray
            button.tintColor = UIColor.white
            return button
        }
    }

    var addExercise: UIButton {
        get {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: workoutControlButtonsWidth, height: workoutControlButtonsHeight))
            button.setTitle("+Exercise", for: .normal)
            button.backgroundColor = UIColor.darkGray
            button.tintColor = UIColor.white
            button.roundCorners([.topRight, .bottomRight], radius: 7)
            button.addLeftBorder(borderColor: UIColor.white, borderWidth: 3)
            return button
        }
    }

    // Create workout info label.
    let createWorkoutCellInfoLabel: UILabel = {
        let cellWidth = UIScreen.main.bounds.width
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.white
        label.frame = CGRect(x: 0, y: 0, width: cellWidth, height: createWorkoutCellInfoLabelHeight)
        // label.layer.cornerRadius = 4
        return label
    }()

    func setupCell(cellType: String) {
        switch cellType {
        case "Header":
            setupHeaderView()   // Create header view.
        case "Cell":
            setupCellView()     // Create cell view.
        default:
            // This should never happen.
            print ("ERROR: Invalid input for CreateWorkoutCell.setupCell() !!")
        }
    }

    private func setupHeaderView() {
        // Add to subview hierarchy.
        let workoutNameView = workoutName
        addSubview(workoutNameView)
        let workoutDescriptionView = workoutDescription
        addSubview(workoutDescriptionView)
        let addDayButton = addDay
        addDayButton.addTarget(self, action: #selector(CreateWorkoutCell.workoutControlButtonPressed), for: .touchUpInside)
        addSubview(addDayButton)
        let addSetButton = addSet
        addSetButton.addTarget(self, action: #selector(CreateWorkoutCell.workoutControlButtonPressed), for: .touchUpInside)
        addSubview(addSetButton)
        let addExerciseButton = addExercise
        addExerciseButton.addTarget(self, action: #selector(CreateWorkoutCell.workoutControlButtonPressed), for: .touchUpInside)
        addSubview(addExerciseButton)

        // For immediate detection if subviews are out of bounds.
        workoutNameView.superview?.clipsToBounds = true

        // For debug to make sure all subviews are within under superview bounds.
        // workoutNameView.superview?.layer.borderWidth = 1

        // Put on screen using constraints.
        var verticalContraint = "V:|-\(headerPixelSpace)-[v0(\(workoutNameFieldHeight))]-\(headerPixelSpace)-[v1(\(workoutDescriptionFieldHeight))]-\(headerPixelSpace)-[v2(\(workoutControlButtonsHeight))]"
        addConstraintsWithFormat(format: verticalContraint, views: workoutNameView, workoutDescriptionView, addDayButton)
        verticalContraint = "V:|-\((headerPixelSpace*3)+workoutNameFieldHeight+workoutDescriptionFieldHeight)-[v0(\(workoutControlButtonsHeight))]"
        addConstraintsWithFormat(format: verticalContraint, views: addSetButton)
        addConstraintsWithFormat(format: verticalContraint, views: addExerciseButton)
        var horizontalConstraint = "H:|-\(headerPixelSpace)-[v0]-\(headerPixelSpace)-|"
        addConstraintsWithFormat(format: horizontalConstraint, views: workoutNameView)
        addConstraintsWithFormat(format: horizontalConstraint, views: workoutDescriptionView)
        horizontalConstraint = "H:|-\(headerPixelSpace)-[v0(\(workoutControlButtonsWidth))]-0-[v1(\(workoutControlButtonsWidth))]-0-[v2(\(workoutControlButtonsWidth))]-\(headerPixelSpace)-|"
        addConstraintsWithFormat(format: horizontalConstraint, views: addDayButton, addSetButton, addExerciseButton)
    }

    private func setupCellView() {
        // Add to subview hierarchy.
        addSubview(createWorkoutCellInfoLabel)

        // For immediate detection if subviews are out of bounds.
        createWorkoutCellInfoLabel.superview?.clipsToBounds = true

        // For debug to make sure all subviews are within under superview bounds.
        createWorkoutCellInfoLabel.layer.borderWidth = 1

        // For debug to make sure all subviews are within under superview bounds.
        // createWorkoutCellInfoLabel.superview?.layer.borderWidth = 1

        // Put on screen using constraints.
        let verticalContraint = "V:|[v0(\(CreateWorkoutCell.createWorkoutCellInfoLabelHeight))]|"
        addConstraintsWithFormat(format: verticalContraint, views: createWorkoutCellInfoLabel)
        let horizontalConstraint = "H:|-14-[v0]-14-|"
        addConstraintsWithFormat(format: horizontalConstraint, views: createWorkoutCellInfoLabel)
    }

    func workoutControlButtonPressed(sender: UIButton) {
        var buttonTitle = "Unknown"
        if let currentTitle = sender.currentTitle {
            buttonTitle = currentTitle
        }
        print("DEBUG: Pressed button: " + buttonTitle)

        switch buttonTitle {
        case "+Day":
            // Create a new cell item.
            let cellTitle = "Workout Day 1"
            let cellType = "Type: Workout"
            let cellDetails = "0 Set(s), 4 Exercise(s)"
            let cellItem = CreateWorkoutCellItem(title: cellTitle, type: cellType, details: cellDetails)
            let vc = UIApplication.topViewController() as! CreateWorkoutVC
            vc.createWorkoutCellList.append(cellItem)
            let indexPath = IndexPath(item: (vc.createWorkoutCellList.count-1), section: 0)
            vc.collectionView?.performBatchUpdates({
                vc.collectionView?.insertItems(at: [indexPath])
                vc.collectionView?.reloadData()
            }, completion: nil)
            vc.collectionView?.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        default:
            print("ERROR: Invalid input for CreateWorkoutCell.workoutControlButtonPressed() !!")
        }
    }
}
