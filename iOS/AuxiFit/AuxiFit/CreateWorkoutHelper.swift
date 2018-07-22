//
//  CreateWorkoutHelper.swift
//  AuxiFit
//
//  Created by Anjandeep Sahni on 18/07/18.
//  Copyright © 2018 Null Pointer Tech. All rights reserved.
//

import UIKit

class CreateWorkoutCell: UICollectionViewCell {

    // workoutName text field dimensions.
    let workoutNameFieldHeight = CGFloat(40.0)
    // workoutDescription text field dimensions.
    let workoutDescriptionFieldHeight = CGFloat(115.0)
    // workoutSegment field dimensions.
    let workoutSegmentFieldHeight = CGFloat(30.0)
    // total number of subviews in header.
    let headerSubViewCount = CGFloat(3.0)
    // pixel spacing between each subview.
    let headerPixelSpace = CGFloat(14.0)

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

    var workoutSegment: UISegmentedControl {
        get {
            let sc = UISegmentedControl(items:["+Day", "+Set", "+Exercise"])
            sc.tintColor = UIColor.darkGray
            let font = UIFont.systemFont(ofSize: 16)
            sc.setTitleTextAttributes([NSFontAttributeName: font], for: .normal)
            sc.selectedSegmentIndex = 0
            return sc
        }
    }

    func setupCell(cellType: String) {
        switch cellType {
        case "Header":
            setupHeaderView()   // Create header view.
        case "Cell":
            print ("Requested Cell in Create Workout")  // TBD
        default:
            print ("Don't know what to do in CreateWorkoutCell init")
        }
    }

    private func setupHeaderView() {
        //backgroundColor = UIColor.white

        // Add to subview hierarchy.
        let workoutNameView = workoutName
        addSubview(workoutNameView)
        let workoutDescriptionView = workoutDescription
        addSubview(workoutDescriptionView)
        let workoutSegmentView = workoutSegment
        // FIXME: Value changed does not trigger action when same index is selected twice.
        workoutSegmentView.addTarget(self, action: #selector(CreateWorkoutCell.workoutSegmentValueChanged), for: .valueChanged)
        addSubview(workoutSegmentView)

        // For immediate detection if subviews are out of bounds.
        workoutSegmentView.superview?.clipsToBounds = true

        // For debug to make sure all subviews are within under superview bounds.
        // workoutSegmentView.superview?.layer.borderWidth = 1

        // Put on screen using constraints.
        let verticalContraint = "V:|-\(headerPixelSpace)-[v0(\(workoutNameFieldHeight))]-\(headerPixelSpace)-[v1(\(workoutDescriptionFieldHeight))]-\(headerPixelSpace)-[v2(\(workoutSegmentFieldHeight))]"
        addConstraintsWithFormat(format: verticalContraint, views: workoutNameView, workoutDescriptionView, workoutSegmentView)
        let horizontalConstraint = "H:|-\(headerPixelSpace)-[v0]-\(headerPixelSpace)-|"
        addConstraintsWithFormat(format: horizontalConstraint, views: workoutNameView)
        addConstraintsWithFormat(format: horizontalConstraint, views: workoutDescriptionView)
        addConstraintsWithFormat(format: horizontalConstraint, views: workoutSegmentView)
    }

    func workoutSegmentValueChanged(sender: UISegmentedControl) {
        var title = "Empty"
        if let segTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) {
            title = segTitle
        }
        print(title)
    }
}
