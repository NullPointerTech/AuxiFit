//
//  WorkoutsVC.swift
//  AuxiFit
//
//  Created by Anjandeep Sahni on 10/07/18.
//  Copyright © 2018 Null Pointer Tech. All rights reserved.
//

import UIKit

private let reuseIdentifier = "workoutCell"

class WorkoutsVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    //Setup navigation bar title size type.
    let navBarLargeTitle = false

    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)

        //Setup tab title here so that over VC's can fetch.
        self.title = "Workouts"
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(WorkoutsCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Set navigation bar title.
        navigationItem.title = self.title!

        // Placeholder in case we want to use large titles in our UI.
        if (self.navBarLargeTitle == true) {
            if #available(iOS 11, *) {
                self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
                self.tabBarController?.navigationController?.navigationItem.largeTitleDisplayMode = .always
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Specify cell size.
        return CGSize(width: view.frame.width, height: 75)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Spacing between different sections.
        return UIEdgeInsetsMake(30, 0, 0, 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //Minimum spacing between cell rows.
        return 10.0
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
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

class WorkoutsCell: UICollectionViewCell {
    // Create workout info label.
    let workoutInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        // Add workout name. Since this is first item, we use mutable.
        // FIXME: Need to fetch this info from database.
        let workoutName = NSMutableAttributedString(string: "Workout 1", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18)])
        let attributedText = workoutName
        // Add last completed date.
        // FIXME: Need to fetch this info from database.
        let workoutLastComp = NSAttributedString(string: "\nLast Completed: 14-07-2018, 18:24:31", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.gray])
        attributedText.append(workoutLastComp)
        // Add next workout details.
        // FIXME: Need to fetch this info from database.
        let workoutNextDet = NSAttributedString(string: "\nNext Workout: Shoulders", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.gray])
        attributedText.append(workoutNextDet)
        // Set line spacing.
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))

        label.attributedText = attributedText
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

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
