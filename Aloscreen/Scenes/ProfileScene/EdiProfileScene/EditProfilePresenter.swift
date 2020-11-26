//
//  EditProfilePresenter.swift
//  Aloscreen
//
//  Created by Rendy K.R on 26/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol EditProfilePresentationLogic {
    func presentSomething(response: EditProfile.Something.Response)
}

class EditProfilePresenter: EditProfilePresentationLogic {
    weak var viewController: EditProfileDisplayLogic?
  
    // MARK: Do something
  
    func presentSomething(response: EditProfile.Something.Response) {
        let viewModel = EditProfile.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
