//
//  ProfileRouter.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol ProfileRoutingLogic {
    func routeToLogin()
    func routeToEdit()
}

protocol ProfileDataPassing {
    var dataStore: ProfileDataStore? { get }
}

class ProfileRouter: NSObject, ProfileRoutingLogic, ProfileDataPassing {
    weak var viewController: ProfileViewController?
    var dataStore: ProfileDataStore?
  
    // MARK: Routing
    
    func routeToLogin() {
        let destinationSB = UIStoryboard(name: "Login", bundle: nil)
        let destinationVC = destinationSB.instantiateViewController(withIdentifier: "NavLoginStoryboard") as! UINavigationController
        destinationVC.modalPresentationStyle = .fullScreen
        viewController?.present(destinationVC, animated: true, completion: nil)
    }
    
    func routeToEdit() {
        viewController?.pushing(storyboardName: "EditProfile", storyboardIdentifier: "EditProfileStoryboard")
        
    }
}
