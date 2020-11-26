//
//  LoginWorker.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import PromiseKit

class LoginWorker {
    func doLogin(request: Login.FetchLogin.Request) -> Promise<UserLocalDataModel> {
        return Promise {
            data in
            do {
                let retrieveAllUsers = try UsersOperational.readUser()
                let filterUser = retrieveAllUsers.filter { $0.username == request.username }
                if filterUser.count > 0 {
                    let foundUser = filterUser[0]
                    if checkPassword(filteredUser: foundUser, requestPassword: request.password) == true {
                        data.fulfill(foundUser)
                    } else {
                        data.reject(NSError(domain: "", code: 400, userInfo: nil))
                    }
                } else {
                    data.reject(NSError(domain: "", code: 404, userInfo: nil))
                }
            } catch {
                data.reject(NSError(domain: "Data Not found", code: 404, userInfo: nil))
            }
        }
    }
    
    func checkPassword(filteredUser: UserLocalDataModel, requestPassword: String) -> Bool {
        if filteredUser.password == requestPassword.encodeBase64() {
            return true
        }
        
        return false
    }
}
