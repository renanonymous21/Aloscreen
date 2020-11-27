//
//  LoginInteractor.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LoginBusinessLogic {
    func fetchLogin(request: Login.FetchLogin.Request)
}

protocol LoginDataStore {
    var loginData: UserLocalDataModel? { get set }
}



class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    var presenter: LoginPresentationLogic?
    var worker: LoginWorker?
    var loginData: UserLocalDataModel?
    
    // MARK: Fetch Login

    func fetchLogin(request: Login.FetchLogin.Request) {
        
        worker = LoginWorker()
        var response: Login.FetchLogin.Response?
        worker?.doLogin(request: request).done {
            res in
            
            self.loginData = res
            response = Login.FetchLogin.Response(data: res)
            
        }.catch(policy: .allErrors) {
            error in
            print("ERROR: ", error.localizedDescription,  "IS CANCELLED: ", error.isCancelled)
        }.finally {
            switch response {
            case .none:
                alert.showMessage(title: "Oops!", msg: "No account that matched with that username or wrong password, please try again with the correct one or register the new one")
                break
            case .some(_):
                if let res = response {
                    self.presenter?.presentLoginData(response: res)
                }
                break
            }
            
        }
    }
}
