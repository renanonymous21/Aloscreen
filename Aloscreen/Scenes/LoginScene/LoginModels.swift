//
//  LoginModels.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Login {
  // MARK: Use cases
    enum FetchLogin {
        struct Request {
            var username: String
            var password: String
        }
        struct Response {
            var data: UserLocalDataModel
        }
        struct ViewModel {
            var show: UserLocalDataModel
        }
    }
}
