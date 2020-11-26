//
//  DetailCategoryPresenter.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Kingfisher

protocol DetailCategoryPresentationLogic {
    func presentDetailPictures(response: DetailCategory.FetchPictures.Response)
}

class DetailCategoryPresenter: DetailCategoryPresentationLogic {
    weak var viewController: DetailCategoryDisplayLogic?
  
    // MARK: Do something
  
    func presentDetailPictures(response: DetailCategory.FetchPictures.Response) {
        let viewModel = DetailCategory.FetchPictures.ViewModel(show: response.data)
        viewController?.displayDetailPictures(viewModel: viewModel)
    }
}
