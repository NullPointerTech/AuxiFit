//
//  CreateWorkoutVC.swift
//  AuxiFit
//
//  Created by Anjandeep Sahni on 18/07/18.
//  Copyright © 2018 Null Pointer Tech. All rights reserved.
//

import UIKit

private let reuseIdentifier = "createWorkoutCell"

class CreateWorkoutVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let workoutNameHeader = "workoutNameHeader"
    weak var createWorkoutHeader: CreateWorkoutCell?
    var createWorkoutCellList = [CreateWorkoutCellItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup view controller color, bounce.
        self.collectionView?.backgroundColor = UIColor(white: 0.90, alpha: 1)
        self.collectionView?.alwaysBounceVertical = true

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(CreateWorkoutCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.register(CreateWorkoutCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: workoutNameHeader)

        // This is to avoid hiding cells behind tab bar.
        self.edgesForExtendedLayout = []
        self.extendedLayoutIncludesOpaqueBars = false
        self.automaticallyAdjustsScrollViewInsets = false
    }

    override func viewWillAppear(_ animated: Bool) {
        self.title = "Create Workout"
        // Set navigation bar title.
        navigationItem.title = self.title!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Specify cell size.
        let cellHeight = CreateWorkoutCell.createWorkoutCellInfoLabelHeight
        return CGSize(width: view.frame.width, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // Specify header size.
        if (section == 0) {
            // First header has workoutName/workoutDescription text field.
            let headerHeight = CreateWorkoutCell.getHeaderHeight()
            return CGSize(width: view.frame.width, height: headerHeight)
        }
        else {
            return CGSize(width: 0, height: 0)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Spacing between different sections.
        if (section == 0) {
            // Need bottom inset here to add some gap between last cell and tab bar.
            // FIXME: If we set bottom inset, scrolling does not work properly.
            //return UIEdgeInsetsMake(0, 0, CreateWorkoutCell.headerPixelSpace, 0)
            return UIEdgeInsetsMake(0, 0, 0, 0)
        }
        else {
            return UIEdgeInsetsMake(25, 0, 0, 0)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //Minimum spacing between cell rows.
        return 0
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return createWorkoutCellList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let createWorkoutCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CreateWorkoutCell
        // Setup workout cell attributes.
        createWorkoutCell.createWorkoutCellItem = createWorkoutCellList[indexPath.item]
        createWorkoutCell.setupCell(cellType: "Cell")
        return createWorkoutCell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        createWorkoutHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: workoutNameHeader, for: indexPath) as? CreateWorkoutCell
        createWorkoutHeader?.setupCell(cellType: "Header")
        return createWorkoutHeader!
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        // This is workaround for iOS11 bug where scroll bar hides behind subview.
        view.layer.zPosition = 0.0
    }

    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CreateWorkoutCell
        var currSelCellEqNewCell = false

        // Deselect current selected cell (if any selected).
        if CreateWorkoutCell.currentSelectedCell != nil {
            let currSelectedCell = collectionView.cellForItem(at: CreateWorkoutCell.currentSelectedCell!) as! CreateWorkoutCell

            if currSelectedCell.cellSelected {
                currSelectedCell.createWorkoutCellInfoLabel.backgroundColor = UIColor.white
                currSelectedCell.createWorkoutCellInfoLabel.textColor = UIColor.black
                let labelAttrText = currSelectedCell.createWorkoutCellInfoLabel.attributedText as? NSMutableAttributedString
                //FIXME: Need to remove hard-coding of 38 here.
                labelAttrText?.addAttribute(NSForegroundColorAttributeName, value: UIColor.gray, range: NSMakeRange((cell.createWorkoutCellItem?.title.count)!, 38))
                currSelectedCell.cellSelected = false
                CreateWorkoutCell.currentSelectedCell = nil
            }

            // Check if new cell and curr selected cell are same.
            if currSelectedCell == cell {
                currSelCellEqNewCell = true
            }
        }

        // If currSelectedCell and new selected cell are same, skip.
        if !currSelCellEqNewCell {
            if cell.cellSelected {
                cell.createWorkoutCellInfoLabel.backgroundColor = UIColor.white
                cell.createWorkoutCellInfoLabel.textColor = UIColor.black
                let labelAttrText = cell.createWorkoutCellInfoLabel.attributedText as? NSMutableAttributedString
                //FIXME: Need to remove hard-coding of 38 here.
                labelAttrText?.addAttribute(NSForegroundColorAttributeName, value: UIColor.gray, range: NSMakeRange((cell.createWorkoutCellItem?.title.count)!, 38))
                cell.cellSelected = false
            }
            else {
                cell.createWorkoutCellInfoLabel.backgroundColor = UIColor.darkGray
                cell.createWorkoutCellInfoLabel.textColor = UIColor.white
                cell.cellSelected = true
                CreateWorkoutCell.currentSelectedCell = indexPath
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        //let cell = collectionView.cellForItem(at: indexPath)
        //cell?.backgroundColor = UIColor.white
    }

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
