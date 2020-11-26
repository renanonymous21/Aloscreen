//
//  LoginRouter.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol LoginRoutingLogic {
    func routeToHome()
    func routeToRegistration()
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {
    
    
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
  
    // MARK: Routing
    
    func routeToHome() {
//        let destinationSB = UIStoryboard(name: "MainTabBar", bundle: nil)
//        let destinationVC = destinationSB.instantiateViewController(withIdentifier: "MainTabBarStoryboard") as! MainTabBarViewController
//        destinationVC.modalPresentationStyle = .fullScreen
//        viewController?.present(destinationVC, animated: true, completion: nil)
        viewController?.presentMainTabBar()
    }
    
    func routeToRegistration() {
//        let destinationSB = UIStoryboard(name: "Registration", bundle: Bundle.main)
//        let destinationVC = destinationSB.instantiateViewController(withIdentifier: "RegistrationStoryboard") as! RegistrationViewController
//        destinationVC.modalPresentationStyle = .fullScreen
//        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
        viewController?.pushing(storyboardName: "Registration", storyboardIdentifier: "RegistrationStoryboard")
    }

   // MARK: Passing data

//    func passDataToHome(source: LoginDataStore, destination: inout HomeCategoryDataStore) {
//        destination.loginData = source.loginData
//    }
}
