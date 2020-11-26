//
//  RegistrationInteractor.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol RegistrationBusinessLogic {
    func registerNewUser(request: Registration.Model.Request)
}

protocol RegistrationDataStore {
  var registrationData: UserLocalDataModel? { get set }
}



class RegistrationInteractor: RegistrationBusinessLogic, RegistrationDataStore {
    var presenter: RegistrationPresentationLogic?
    var worker: RegistrationWorker?
    var registrationData: UserLocalDataModel?
    // MARK: Do something

    func registerNewUser(request: Registration.Model.Request) {
        worker = RegistrationWorker()
        var response: Registration.Model.Response?
        worker?.doRegisterUser(request: request).done {
            res in
            self.registrationData = res
            response = Registration.Model.Response(data: res)
        }.catch(policy: .allErrors) {
            error in
            print("ERROR: ", error.localizedDescription,  "IS CANCELLED: ", error.isCancelled)
        }.finally {
            switch response {
            case .none:
                alert.showMessage(title: "Oops!", msg: "Something wrong when try to register your account, please try again later")
            case .some(_):
                self.presenter?.presentRegosteredUser(response: response!)
            }

        }
    }
}
