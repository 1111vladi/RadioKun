//
//  NavControllerViewController.swift
//  ACRCloudDemo_Swift
//
//  Created by Nico on 29/09/2018.
//  Copyright © 2018 olym.yin. All rights reserved.
//

import UIKit

class NavController: UINavigationController {

    // Used for changing the theme of the navigation
    let theme = ThemeManager.currentTheme();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barTintColor = theme.navigationBackgroundColor;
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : theme.mainColor]; // Change title color
    }
    
        
    
  
}
