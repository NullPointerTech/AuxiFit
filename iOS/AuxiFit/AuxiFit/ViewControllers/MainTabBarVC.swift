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
        
        // Create Tab One
        let tabOne = TabOneVC()
        let tabOneBarItem = UITabBarItem(title: tabOne.title, image: nil, selectedImage: nil)
        tabOne.tabBarItem = tabOneBarItem
        
        // Create Tab Two
        let tabTwo = TabTwoVC()
        let tabTwoBarItem = UITabBarItem(title: tabTwo.title, image: nil, selectedImage: nil)
        tabTwo.tabBarItem = tabTwoBarItem
        
        // Create Tab Three
        let tabThree = TabThreeVC()
        let tabThreeBarItem = UITabBarItem(title: tabThree.title, image: nil, selectedImage: nil)
        tabThree.tabBarItem = tabThreeBarItem
        
        // Create Tab Four
        let tabFour = TabFourVC()
        let tabFourBarItem = UITabBarItem(title: tabFour.title, image: nil, selectedImage: nil)
        tabFour.tabBarItem = tabFourBarItem
        
        // Create Tab Five
        let tabFive = TabFiveVC()
        let tabFiveBarItem = UITabBarItem(title: tabFive.title, image: nil, selectedImage: nil)
        tabFive.tabBarItem = tabFiveBarItem

        // Set all relevant tabs in one list.
        self.viewControllers = [tabOne, tabTwo, tabThree, tabFour, tabFive]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
