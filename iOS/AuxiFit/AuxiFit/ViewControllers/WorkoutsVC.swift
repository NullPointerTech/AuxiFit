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
        return CGSize(width: view.frame.width, height: 50)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
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
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Text"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(nameLabel)
        // Put on screen using constraints.
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
    }
}
