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
        return CGSize(width: view.frame.width, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // Specify header size.
        if (section == 0) {
            // First header has workoutName/workoutDescription text field.
            let tempObject = CreateWorkoutCell()
            let headerHeight = tempObject.workoutNameFieldHeight + tempObject.workoutDescriptionFieldHeight + tempObject.workoutControlButtonsHeight + (tempObject.headerPixelSpace * (tempObject.headerSubViewCount + 1))
            return CGSize(width: view.frame.width, height: headerHeight)
        }
        else {
            return CGSize(width: 0, height: 0)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Spacing between different sections.
        if (section == 0) {
            return UIEdgeInsetsMake(0, 0, 0, 0)
        }
        else {
            return UIEdgeInsetsMake(25, 0, 0, 0)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //Minimum spacing between cell rows.
        return 10.0
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let createWorkoutCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CreateWorkoutCell
        createWorkoutCell.setupCell(cellType: "Cell")
        return createWorkoutCell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        createWorkoutHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: workoutNameHeader, for: indexPath) as? CreateWorkoutCell
        createWorkoutHeader?.setupCell(cellType: "Header")
        return createWorkoutHeader!
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

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
