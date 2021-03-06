//
//  ExercisesVC.swift
//  AuxiFit
//
//  Created by Anjandeep Sahni on 30/08/18.
//  Copyright © 2018 Null Pointer Tech. All rights reserved.
//

import UIKit
import FirebaseDatabase

private let reuseIdentifier = "exerciseCell"

class ExercisesVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    // List of exercises to display.
    var exercisesList = [String]()
    var refExercises: DatabaseReference?
    var exerciseDbHandle: DatabaseHandle?

    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        //Setup tab title here so that other VC's can fetch.
        self.title = "Exercises"
    }

    // This is required by compiler.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup view controller color, bounce.
        self.collectionView?.backgroundColor = UIColor(white: 0.35, alpha: 1)
        self.collectionView?.alwaysBounceVertical = true
        self.navigationController?.navigationBar.isTranslucent = false

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(ExerciseCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Set the firebase database reference.
        refExercises = Database.database().reference()
        var indexPaths = [IndexPath]()

        // Retreive the exercise database and listen for changes.
        exerciseDbHandle = refExercises?.child("Exercises").observe(.value, with: { (snapshot) in
            // Code to execute when the exercise database is changed.
            // Take value from the snapshot and add it to the exercisesList.
            for child in snapshot.children{
                let exerciseEntry = child as! DataSnapshot
                self.exercisesList.append(exerciseEntry.value as! String)
                indexPaths.append(IndexPath(row: self.exercisesList.index(of: exerciseEntry.value as! String)!, section: 0))
            }
            self.collectionView?.performBatchUpdates({
                self.collectionView?.insertItems(at: indexPaths)
                self.collectionView?.reloadData()
            }, completion: nil)
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Set navigation bar title.
        navigationItem.title = self.title!

        // To highlight selected cell.
        self.collectionView?.delaysContentTouches = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Specify cell size.
        return CGSize(width: view.frame.width, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Spacing between different sections.
        if (section == 0) {
            return UIEdgeInsetsMake(10, 0, 0, 0)
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
        return exercisesList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let exerciseCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ExerciseCell
        // Setup exercise cell attributes.
        exerciseCell.exerciseCellItem = exercisesList[indexPath.item]
        return exerciseCell
    }

    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.lightGray
    }

    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.white
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
