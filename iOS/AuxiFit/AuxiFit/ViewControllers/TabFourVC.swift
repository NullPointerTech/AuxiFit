//
//  TabFourVC.swift
//  AuxiFit
//
//  Created by Anjandeep Sahni on 10/07/18.
//  Copyright © 2018 Null Pointer Tech. All rights reserved.
//

import UIKit

class TabFourVC: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        
        //Setup tab title here so that over VC's can fetch.
        self.title = "Progress"
    }
    
    // This is required by compiler.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup view controller color.
        self.view.backgroundColor = UIColor(white: 0.75, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTabTitle() -> String {
        // Return the title for this tab.
        var tabTitle = ""
        if self.title != nil {
            tabTitle = self.title!
        }
        return tabTitle
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
