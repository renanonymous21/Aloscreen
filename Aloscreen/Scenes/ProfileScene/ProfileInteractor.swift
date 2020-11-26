//
//  ProfileInteractor.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProfileBusinessLogic {
    func doSomething(request: Profile.Something.Request)
}

protocol ProfileDataStore {
  //var name: String { get set }
}



class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    var presenter: ProfilePresentationLogic?
    var worker: ProfileWorker?
    
    // MARK: Do something

    func doSomething(request: Profile.Something.Request) {
    worker = ProfileWorker()
    worker?.doSomeWork()

    let response = Profile.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
