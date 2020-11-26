//
//  RegistrationRouter.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol RegistrationRoutingLogic {
    func routeToHome()
}

protocol RegistrationDataPassing {
    var dataStore: RegistrationDataStore? { get }
}

class RegistrationRouter: NSObject, RegistrationRoutingLogic, RegistrationDataPassing {
    weak var viewController: RegistrationViewController?
    var dataStore: RegistrationDataStore?
  
    // MARK: Routing

    func routeToHome() {
        let destinationSB = UIStoryboard(name: "MainTabBar", bundle: nil)
        let destinationVC = destinationSB.instantiateViewController(withIdentifier: "MainTabBarStoryboard") as! MainTabBarViewController
        destinationVC.modalPresentationStyle = .fullScreen
        viewController?.present(destinationVC, animated: true, completion: nil)
    }

    // MARK: Passing data

    //func passDataToSomewhere(source: RegistrationDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}
