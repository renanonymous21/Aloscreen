//
//  EditProfileInteractor.swift
//  Aloscreen
//
//  Created by Rendy K.R on 26/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol EditProfileBusinessLogic {
    func doSomething(request: EditProfile.Something.Request)
}

protocol EditProfileDataStore {
  //var name: String { get set }
}



class EditProfileInteractor: EditProfileBusinessLogic, EditProfileDataStore {
    var presenter: EditProfilePresentationLogic?
    var worker: EditProfileWorker?
    
    // MARK: Do something

    func doSomething(request: EditProfile.Something.Request) {
    worker = EditProfileWorker()
    worker?.doSomeWork()

    let response = EditProfile.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
