//
//  RoutingViewControllerExtension.swift
//  Aloscreen
//
//  Created by Rendy K.R on 26/11/20.
//

import UIKit

extension UIViewController {
    func presenting(storyboardName: String, storyboardIdentifier: String) {
        let sb = UIStoryboard(name: storyboardName, bundle: nil)
        let destinationSB = sb.instantiateViewController(withIdentifier: storyboardIdentifier)
        destinationSB.modalPresentationStyle = .fullScreen
        self.present(destinationSB, animated: true, completion: nil)
    }
    
    func pushing(storyboardName: String, storyboardIdentifier: String) {
        let sb = UIStoryboard(name: storyboardName, bundle: nil)
        let destinationSB = sb.instantiateViewController(withIdentifier: storyboardIdentifier)
        destinationSB.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(destinationSB, animated: true)
    }
    
    func presentMainTabBar() {
        let destinationSB = UIStoryboard(name: "MainTabBar", bundle: nil)
        let destinationVC = destinationSB.instantiateViewController(withIdentifier: "MainTabBarStoryboard") as! MainTabBarViewController
        destinationVC.modalPresentationStyle = .fullScreen
        self.present(destinationVC, animated: true, completion: nil)
    }
}
