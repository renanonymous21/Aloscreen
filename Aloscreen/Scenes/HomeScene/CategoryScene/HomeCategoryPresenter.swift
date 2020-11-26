//
//  HomeCategoryPresenter.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeCategoryPresentationLogic {
    func presentCategories(response: HomeCategory.FetchCategory.Response)
}

class HomeCategoryPresenter: HomeCategoryPresentationLogic {
    weak var viewController: HomeCategoryDisplayLogic?
  
    // MARK: Do something
  
    func presentCategories(response: HomeCategory.FetchCategory.Response) {
        let viewModel = HomeCategory.FetchCategory.ViewModel(show: response.data)
        viewController?.displayCategories(viewModel: viewModel)
    }
}
