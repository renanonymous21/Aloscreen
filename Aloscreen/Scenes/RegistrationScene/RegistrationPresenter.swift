//
//  RegistrationPresenter.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol RegistrationPresentationLogic {
    func presentRegosteredUser(response: Registration.Model.Response)
}

class RegistrationPresenter: RegistrationPresentationLogic {
    weak var viewController: RegistrationDisplayLogic?
  
    // MARK: Do something
  
    func presentRegosteredUser(response: Registration.Model.Response) {
        let viewModel = Registration.Model.ViewModel(displayData: response.data)
        UserDefaults.standard.setValue(viewModel.displayData.username, forKey: "username")
        UsersOperational.changeLoginStatus(username: viewModel.displayData.username, isLoggedIn: true, isLogout: false)
        viewController?.displayAfterRegister(viewModel: viewModel)
    }
}
