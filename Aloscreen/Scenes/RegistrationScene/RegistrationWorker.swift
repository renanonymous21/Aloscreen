//
//  RegistrationWorker.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import PromiseKit

class RegistrationWorker {
    func doRegisterUser(request: Registration.Model.Request) -> Promise<UserLocalDataModel> {
        return Promise {
            data in
            do {
                let allUser = try UsersOperational.readUser()
                let filterUser = allUser.filter { $0.username == request.username }
                if filterUser.count == 0 {
                    UsersOperational.insertUser(name: request.name, username: request.username, password: request.password.encodeBase64(), phone: "-", email: "-", gender: "-")
                    let registeredUser = try UsersOperational.readUser().filter { $0.username == request.username }[0]
                    data.fulfill(registeredUser)
                } else {
                    data.reject(NSError(domain: "Username already exist", code: 500, userInfo: nil))
                }
                
            } catch {
                data.reject(NSError(domain: "Username already exist", code: 500, userInfo: nil))
            }
        }
    }
}
