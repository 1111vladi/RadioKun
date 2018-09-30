//
//  TabControllerViewController.swift
//  ACRCloudDemo_Swift
//
//  Created by Nico on 29/09/2018.
//  Copyright © 2018 olym.yin. All rights reserved.
//

import UIKit

class TabController: UITabBarController {

    // Used for changing the theme of the tab
    let theme = ThemeManager.currentTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.barTintColor = theme.tabBarBackgroundColor;
    }
 
}
