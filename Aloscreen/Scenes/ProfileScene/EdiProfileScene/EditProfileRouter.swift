//
//  EditProfileRouter.swift
//  Aloscreen
//
//  Created by Rendy K.R on 26/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol EditProfileRoutingLogic {
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol EditProfileDataPassing {
    var dataStore: EditProfileDataStore? { get }
}

class EditProfileRouter: NSObject, EditProfileRoutingLogic, EditProfileDataPassing {
    weak var viewController: EditProfileViewController?
    var dataStore: EditProfileDataStore?
  
    // MARK: Routing

    //func routeToSomewhere(segue: UIStoryboardSegue?) {
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}

    // MARK: Navigation

    //func navigateToSomewhere(source: EditProfileViewController, destination: SomewhereViewController) {
    //  source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    //func passDataToSomewhere(source: EditProfileDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}
