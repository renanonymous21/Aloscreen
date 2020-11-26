//
//  DetailCategoryRouter.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol DetailCategoryRoutingLogic {
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol DetailCategoryDataPassing {
    var dataStore: DetailCategoryDataStore? { get }
}

class DetailCategoryRouter: NSObject, DetailCategoryRoutingLogic, DetailCategoryDataPassing {
    weak var viewController: DetailCategoryViewController?
    var dataStore: DetailCategoryDataStore?
  
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

    //func navigateToSomewhere(source: DetailCategoryViewController, destination: SomewhereViewController) {
    //  source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    //func passDataToSomewhere(source: DetailCategoryDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}
