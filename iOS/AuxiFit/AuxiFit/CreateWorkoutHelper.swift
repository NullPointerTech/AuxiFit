//
//  CreateWorkoutHelper.swift
//  AuxiFit
//
//  Created by Anjandeep Sahni on 18/07/18.
//  Copyright © 2018 Null Pointer Tech. All rights reserved.
//

import UIKit

enum CreateWorkoutCellItemType: String {
    case Workout
    case Superset
    case Exercise

    func cellType() -> String {
        return self.rawValue
    }
}

class CreateWorkoutCellItem {
    var title: String
    var type: String
    var details: String
    var cellType: CreateWorkoutCellItemType

    init(title: String, type: String, details: String, cellType: CreateWorkoutCellItemType)
    {
        self.title = title
        self.type = type
        self.details = details
        self.cellType = cellType
    }
}

class CreateWorkoutCell: UICollectionViewCell {

    // workoutName text field dimensions.
    static let workoutNameFieldHeight = CGFloat(40.0)
    // workoutDescription text field dimensions.
    static let workoutDescriptionFieldHeight = CGFloat(115.0)
    // addDay, addSet, addExercise button dimensions. NOTE: 28 = 2*headerPixelSpace
    static let workoutControlButtonsHeight = CGFloat(30.0)
    static let workoutControlButtonsWidth = CGFloat((UIScreen.main.bounds.width - (CreateWorkoutCell.headerPixelSpace * 2))/3)
    // total number of subviews in header.
    static let headerSubViewCount = CGFloat(3.0)
    // pixel spacing between each subview.
    static let headerPixelSpace = CGFloat(14.0)
    // createWorkoutCellInfoLabel dimensions.
    static var createWorkoutCellInfoLabelHeight = CGFloat(65.0)
    // to track current selected cell
    static var currentSelectedCell: IndexPath? = nil
    // to track if given cell is selected or not.
    var cellSelected = false
    // to track the cell object index. Used in prepareForReuse.
    var cellIndexPath: IndexPath? = nil

    // Setup cell parameters.
    var createWorkoutCellItem: CreateWorkoutCellItem? {
        didSet {
            // Add cell title. Since this is first item, we use mutable.
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
            let textField = UITextField(frame: CGRect(x: 0, y: 0, width: textWidth, height:  CreateWorkoutCell.workoutNameFieldHeight))
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
            let textView = UITextView(frame: CGRect(x: 0, y: 0, width: textWidth, height:  CreateWorkoutCell.workoutDescriptionFieldHeight))
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
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: CreateWorkoutCell.workoutControlButtonsWidth, height: CreateWorkoutCell.workoutControlButtonsHeight))
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
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: CreateWorkoutCell.workoutControlButtonsWidth, height: CreateWorkoutCell.workoutControlButtonsHeight))
            button.setTitle("+Set", for: .normal)
            button.backgroundColor = UIColor.darkGray
            button.tintColor = UIColor.white
            return button
        }
    }

    var addExercise: UIButton {
        get {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: CreateWorkoutCell.workoutControlButtonsWidth, height: CreateWorkoutCell.workoutControlButtonsHeight))
            button.setTitle("+Exercise", for: .normal)
            button.backgroundColor = UIColor.darkGray
            button.tintColor = UIColor.white
            button.roundCorners([.topRight, .bottomRight], radius: 7)
            button.addLeftBorder(borderColor: UIColor.white, borderWidth: 3)
            return button
        }
    }

    var workoutControlButtonsBG: UIView {
        get {
            let bgRectWidth = UIScreen.main.bounds.width
            let bgRectHeight = CreateWorkoutCell.workoutControlButtonsHeight + (CreateWorkoutCell.headerPixelSpace * 2)
            let bgRect = CGRect(x: 0, y: 0, width: bgRectWidth, height: bgRectHeight)
            let rectView = UIView(frame: bgRect)
            let vc = (UIApplication.topViewController()) as! CreateWorkoutVC
            rectView.backgroundColor = vc.collectionView?.backgroundColor
            return rectView
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
        let workoutControlButtonsBGView = workoutControlButtonsBG
        addSubview(workoutControlButtonsBGView)
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

        // Init constraint params.
        let headerPixelSpace = CreateWorkoutCell.headerPixelSpace
        let workoutNameFieldHeight = CreateWorkoutCell.workoutNameFieldHeight
        let workoutDescriptionFieldHeight = CreateWorkoutCell.workoutDescriptionFieldHeight
        let workoutControlButtonsHeight = CreateWorkoutCell.workoutControlButtonsHeight
        let workoutControlButtonsWidth = CreateWorkoutCell.workoutControlButtonsWidth

        // Put on screen using constraints.
        var verticalContraint = "V:|-\(headerPixelSpace)-[v0(\(workoutNameFieldHeight))]-\(headerPixelSpace)-[v1(\(workoutDescriptionFieldHeight))]-\(headerPixelSpace)-[v2(\(workoutControlButtonsHeight))]"
        addConstraintsWithFormat(format: verticalContraint, views: workoutNameView, workoutDescriptionView, addDayButton)
        verticalContraint = "V:|-\((headerPixelSpace*3)+workoutNameFieldHeight+workoutDescriptionFieldHeight)-[v0(\(workoutControlButtonsHeight))]"
        addConstraintsWithFormat(format: verticalContraint, views: addSetButton)
        addConstraintsWithFormat(format: verticalContraint, views: addExerciseButton)
        verticalContraint = "V:|-\((headerPixelSpace*2)+workoutNameFieldHeight+workoutDescriptionFieldHeight)-[v0]|"
        addConstraintsWithFormat(format: verticalContraint, views: workoutControlButtonsBGView)
        var horizontalConstraint = "H:|-\(headerPixelSpace)-[v0]-\(headerPixelSpace)-|"
        addConstraintsWithFormat(format: horizontalConstraint, views: workoutNameView)
        addConstraintsWithFormat(format: horizontalConstraint, views: workoutDescriptionView)
        horizontalConstraint = "H:|[v0]|"
        addConstraintsWithFormat(format: horizontalConstraint, views: workoutControlButtonsBGView)
        horizontalConstraint = "H:|-\(headerPixelSpace)-[v0(\(workoutControlButtonsWidth))]-0-[v1(\(workoutControlButtonsWidth))]-0-[v2(\(workoutControlButtonsWidth))]-\(headerPixelSpace)-|"
        addConstraintsWithFormat(format: horizontalConstraint, views: addDayButton, addSetButton, addExerciseButton)
    }

    private func setupCellView() {
        // Override default createWorkoutCellInfoLabel config based
        // on cell selection status, since we reuse cells.
        if CreateWorkoutCell.currentSelectedCell == self.cellIndexPath {
            self.setupCellSelected()
        }
        else {
            self.setupCellDeselected()
        }

        // Add to subview hierarchy.
        addSubview(createWorkoutCellInfoLabel)

        // For immediate detection if subviews are out of bounds.
        createWorkoutCellInfoLabel.superview?.clipsToBounds = true
        // Cell border.
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
            // Create a new cell item of workout type.
            let cellTitle = "Workout Day 1"
            let cellType = "Type: Workout"
            let cellDetails = "0 Set(s), 4 Exercise(s)"
            let cellItem = CreateWorkoutCellItem(title: cellTitle, type: cellType, details: cellDetails, cellType: CreateWorkoutCellItemType.Workout)
            let vc = UIApplication.topViewController() as! CreateWorkoutVC
            vc.createWorkoutCellList.append(cellItem)
            let indexPath = IndexPath(row: (vc.createWorkoutCellList.count-1), section: 0)
            vc.collectionView?.performBatchUpdates({
                vc.collectionView?.insertItems(at: [indexPath])
                vc.collectionView?.reloadData()
            }, completion: nil)
            vc.collectionView?.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)

            // FIXME: Below is just placeholder code for debugging issue where
            // auto-scroll on cell addition does not account for bottom inset.
            // let cellAttr = vc.collectionView?.layoutAttributesForItem(at: indexPath)
            // print("minY: ", (cellAttr?.frame.minY)!, "maxY: ", (cellAttr?.frame.maxY)!)

            /*
            // Check if new cell is already visible.
            let cellRect = CGRect(x: (cellAttr?.frame.minX)!, y: (cellAttr?.frame.minY)!, width: (cellAttr?.frame.width)!, height: (cellAttr?.frame.height)!)
            if (vc.collectionView?.bounds.contains(cellRect))! {
                print("Visible: ", indexPath)
            }
            else {
                // New cell is not completely visible. Scroll approproately.
                let delta = (cellAttr?.frame.maxY)! - (vc.collectionView?.frame.maxY)! + CreateWorkoutCell.headerPixelSpace
                vc.collectionView?.setContentOffset(CGPoint(x: 0, y: delta), animated: false)
            }
            */
            break

        case "+Set":
            // +Set is only valid if a workout day is selected.
            let curSelCellIndex = (CreateWorkoutCell.currentSelectedCell)
            if curSelCellIndex != nil {
                let vc = UIApplication.topViewController() as! CreateWorkoutVC
                // Only add superset cell if selected workout cell is visible.
                if((vc.collectionView?.indexPathsForVisibleItems)?.contains(curSelCellIndex!))! {
                    // Only add superset cell if selected cell type is Workout cell.
                    let selCell = vc.collectionView?.cellForItem(at: curSelCellIndex!) as! CreateWorkoutCell
                    let selCellType = selCell.createWorkoutCellItem?.cellType
                    if selCellType == CreateWorkoutCellItemType.Workout {
                        // Create a new cell item of superset type.
                        let cellTitle = "Set 1"
                        let cellType = "Type: Superset"
                        let cellDetails = "0 Exercise(s)"
                        let cellItem = CreateWorkoutCellItem(title: cellTitle, type: cellType, details: cellDetails, cellType: CreateWorkoutCellItemType.Superset)
                        let indexPath = IndexPath(row: ((CreateWorkoutCell.currentSelectedCell?.row)!+1), section: 0)
                        vc.createWorkoutCellList.insert(cellItem, at: indexPath.row)
                        vc.collectionView?.performBatchUpdates({
                            vc.collectionView?.insertItems(at: [indexPath])
                            vc.collectionView?.reloadData()
                        }, completion: nil)
                        vc.collectionView?.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
                    }
                }
            }
            break

        case "+Exercise":
            // FIXME: Exercise cell should be created based on exercise chosen from database.
            let curSelCellIndex = (CreateWorkoutCell.currentSelectedCell)
            let vc = UIApplication.topViewController() as! CreateWorkoutVC
            var indexPath = IndexPath(row: 0, section: 0)   //Init to zero, will be overwritten.
            var newCellCreated = false
            if curSelCellIndex != nil {
                // Add new exercise after selected cell.
                // Only add exercise cell if selected Workout/Superset cell is visible.
                if((vc.collectionView?.indexPathsForVisibleItems)?.contains(curSelCellIndex!))! {
                    // Only add superset cell if selected cell type is Workout/Superset cell.
                    let selCell = vc.collectionView?.cellForItem(at: curSelCellIndex!) as! CreateWorkoutCell
                    let selCellType = selCell.createWorkoutCellItem?.cellType
                    if selCellType == CreateWorkoutCellItemType.Workout || selCellType == CreateWorkoutCellItemType.Superset {
                        // Create a new cell item of exercise type.
                        let cellTitle = "Barbell Bench Press"
                        let cellType = "Type: Exercise"
                        let cellDetails = "Category: Pectorals"
                        let cellItem = CreateWorkoutCellItem(title: cellTitle, type: cellType, details: cellDetails, cellType: CreateWorkoutCellItemType.Exercise)
                        indexPath = IndexPath(row: ((CreateWorkoutCell.currentSelectedCell?.row)!+1), section: 0)
                        vc.createWorkoutCellList.insert(cellItem, at: indexPath.row)
                        newCellCreated = true
                    }
                }
            }
            else {
                // Add new exercise towards end of collection view.
                let cellTitle = "Barbell Bench Press"
                let cellType = "Type: Exercise"
                let cellDetails = "Category: Pectorals"
                let cellItem = CreateWorkoutCellItem(title: cellTitle, type: cellType, details: cellDetails, cellType: CreateWorkoutCellItemType.Exercise)
                let vc = UIApplication.topViewController() as! CreateWorkoutVC
                vc.createWorkoutCellList.append(cellItem)
                indexPath = IndexPath(row: (vc.createWorkoutCellList.count-1), section: 0)
                newCellCreated = true
            }
            if newCellCreated == true {
                vc.collectionView?.performBatchUpdates({
                    vc.collectionView?.insertItems(at: [indexPath])
                    vc.collectionView?.reloadData()
                }, completion: nil)
                vc.collectionView?.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
            }
            break

        default:
            print("ERROR: Invalid input for CreateWorkoutCell.workoutControlButtonPressed() !!")
        }
    }

    static func getHeaderHeight() -> CGFloat {
        let headerHeight = CreateWorkoutCell.workoutNameFieldHeight + CreateWorkoutCell.workoutDescriptionFieldHeight + CreateWorkoutCell.workoutControlButtonsHeight + (CreateWorkoutCell.headerPixelSpace * (CreateWorkoutCell.headerSubViewCount + 1))
        return headerHeight
    }

    func setupCellSelected() {
        self.createWorkoutCellInfoLabel.backgroundColor = UIColor.darkGray
        self.createWorkoutCellInfoLabel.textColor = UIColor.white
        self.cellSelected = true
    }

    func setupCellDeselected() {
        self.createWorkoutCellInfoLabel.backgroundColor = UIColor.white
        self.createWorkoutCellInfoLabel.textColor = UIColor.black
        let labelAttrText = self.createWorkoutCellInfoLabel.attributedText as? NSMutableAttributedString
        let tintRangeStart = (self.createWorkoutCellItem?.title.count)! + 1     // +1 for newline.
        let tintRangeLen = (self.createWorkoutCellItem?.type.count)! + (self.createWorkoutCellItem?.details.count)! + 1     // +1 for newline.
        labelAttrText?.addAttribute(NSForegroundColorAttributeName, value: UIColor.gray, range: NSMakeRange(tintRangeStart, tintRangeLen))
        self.cellSelected = false
    }
}

class CreateWorkoutStickyHeadersLayout: UICollectionViewFlowLayout {

    // Whenever the bounds of the collection view change,
    // we need to invalidate the layout of the collection view.
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // Get the layout attributes of the elements in the given rectangle.
        guard let layoutAttributes = super.layoutAttributesForElements(in: rect) else { return nil }

        // Sections for which new layout attributes are stored.
        let sectionsToAdd = NSMutableIndexSet()
        // To store the new layout attributes of the elements.
        var newLayoutAttributes = [UICollectionViewLayoutAttributes]()

        // Loop over layoutAttributes and add the layout attributes of the
        // elements of type .cell to newLayoutAttributes.
        // For every element of type .cell, we ask it what section it belongs to.
        // We add the index of the section to sectionsToAdd.
        // For elements of type .supplementaryView, we ask it for its section
        // and add that to sectionsToAdd.
        for layoutAttributesSet in layoutAttributes {
            if layoutAttributesSet.representedElementCategory == .cell {
                // Add Layout Attributes
                newLayoutAttributes.append(layoutAttributesSet)
                // Update Sections to Add
                sectionsToAdd.add(layoutAttributesSet.indexPath.section)
            } else if layoutAttributesSet.representedElementCategory == .supplementaryView {
                // Update Sections to Add
                sectionsToAdd.add(layoutAttributesSet.indexPath.section)
            }
        }

        // For every index of sectionsToAdd, we create an index path
        // and ask the flow layout for the layout attributes of the
        // corresponding supplementary view.
        for section in sectionsToAdd {
            let indexPath = IndexPath(item: 0, section: section)
            if let sectionAttributes = self.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: indexPath) {
                newLayoutAttributes.append(sectionAttributes)
            }
        }
        return newLayoutAttributes
    }

    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let layoutAttributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath) else { return nil }
        guard let collectionView = collectionView else { return layoutAttributes }

        // Stores the vertical content offset of the collection view.
        let contentOffsetY = collectionView.contentOffset.y
        // Stores the frame of the supplementary view.
        var frameForSupplementaryView = layoutAttributes.frame

        // Find amount of header to hide. All except control buttons.
        // Also adjust for navigation and status bar.
        let hideHeaderHeight = CreateWorkoutCell.getHeaderHeight() - (CreateWorkoutCell.workoutControlButtonsHeight + (CreateWorkoutCell.headerPixelSpace * (CreateWorkoutCell.headerSubViewCount - 1)))

        //Calculate when contentOffsetY will cross header height (which will be hidden).
        let contentOffsetYLimit = hideHeaderHeight

        //Set position of header based on contentOffsetY.
        if contentOffsetY > contentOffsetYLimit {
            frameForSupplementaryView.origin.y = contentOffsetY - hideHeaderHeight
        }
        else {
            frameForSupplementaryView.origin.y = 0
        }

        layoutAttributes.frame = frameForSupplementaryView
        return layoutAttributes
    }
}
