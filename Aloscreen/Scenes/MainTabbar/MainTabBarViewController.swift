//
//  MainTabBarViewController.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTabBarUI()
    }
    
    private func setupTabBarUI() {
        // MARK:  Icon & Title Colors
        self.tabBar.barTintColor = .white
        self.tabBar.unselectedItemTintColor = Colors.systemGray2
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.systemGray2], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.mainBlue], for: .selected)
        
        let homeItem = (self.tabBar.items?[0])! as UITabBarItem
        let profileItem = (self.tabBar.items?[1])! as UITabBarItem
        
        homeItem.setIcon(icon: .linearIcons(.home), size: nil, textColor: Colors.systemGray2, selectedTextColor: Colors.mainBlue)
        homeItem.title = "Home"
        profileItem.setIcon(icon: .linearIcons(.user), size: nil, textColor: Colors.systemGray2, selectedTextColor: Colors.mainBlue)
        profileItem.title = "Profile"
    }

}
