//
//  LoginPresenter.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LoginPresentationLogic {
    func presentLoginData(response: Login.FetchLogin.Response)
}

class LoginPresenter: LoginPresentationLogic {
    
    weak var viewController: LoginDisplayLogic?
  
    // MARK: Do something
  
    func presentLoginData(response: Login.FetchLogin.Response) {
        let resData = response.data
        let viewModel = Login.FetchLogin.ViewModel(show: resData)
        UserDefaults.standard.setValue(viewModel.show.username, forKey: "username")
        UsersOperational.changeLoginStatus(username: viewModel.show.username, isLoggedIn: true, isLogout: false)
        viewController?.displayLogin(viewModel: viewModel)
    }
}
