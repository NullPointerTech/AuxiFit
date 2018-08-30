//
//  MainTabBarVC.swift
//  AuxiFit
//
//  Created by Anjandeep Sahni on 10/07/18.
//  Copyright © 2018 Null Pointer Tech. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup color for MainTabBarVC.
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        // Assign self for delegate so that MainTabBarVC
        // can respond to UITabBarControllerDelegate methods
        self.delegate = self
        
        // Create Tab One and its navigation controller.
        let tabOne = WorkoutsVC(collectionViewLayout: UICollectionViewFlowLayout())
        let tabOneNC = UINavigationController(rootViewController: tabOne)
        tabOneNC.title = tabOne.title
        
        // Create Tab Two and its navigation controller.
        let tabTwo = TabTwoVC()
        let tabTwoNC = UINavigationController(rootViewController: tabTwo)
        tabTwoNC.title = tabTwo.title
        
        // Create Tab Three and its navigation controller.
        let tabThree = ExercisesVC(collectionViewLayout: UICollectionViewFlowLayout())
        let tabThreeNC = UINavigationController(rootViewController: tabThree)
        tabThreeNC.title = tabThree.title
        
        // Create Tab Four and its navigation controller.
        let tabFour = TabFourVC()
        let tabFourNC = UINavigationController(rootViewController: tabFour)
        tabFourNC.title = tabFour.title
        
        // Create Tab Five and its navigation controller.
        let tabFive = TabFiveVC()
        let tabFiveNC = UINavigationController(rootViewController: tabFive)
        tabFiveNC.title = tabFive.title

        // Set all relevant tabs in one list.
        self.viewControllers = [tabOneNC, tabTwoNC, tabThreeNC, tabFourNC, tabFiveNC]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
}
