//
//  ProfilePresenter.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProfilePresentationLogic {
    func presentSomething(response: Profile.Something.Response)
}

class ProfilePresenter: ProfilePresentationLogic {
    weak var viewController: ProfileDisplayLogic?
  
    // MARK: Do something
  
    func presentSomething(response: Profile.Something.Response) {
        let viewModel = Profile.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
