//
//  HomeCategoryInteractor.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeCategoryBusinessLogic {
    func getCategories(request: HomeCategory.FetchCategory.Request)
}

protocol HomeCategoryDataStore {
    var categoryData: [Category]? { get set }
}



class HomeCategoryInteractor: HomeCategoryBusinessLogic, HomeCategoryDataStore {
    var presenter: HomeCategoryPresentationLogic?
    var worker: HomeCategoryWorker?
    var categoryData: [Category]?
    // MARK: Do something

    func getCategories(request: HomeCategory.FetchCategory.Request) {
        worker = HomeCategoryWorker()
        var response: HomeCategory.FetchCategory.Response?
        worker?.fetchCategories(request: request).done {
            cat in

            self.categoryData = cat
            response = HomeCategory.FetchCategory.Response(data: cat)
        }.catch(policy: .allErrors) {
            error in
            print("ERROR: ", error.localizedDescription,  "IS CANCELLED: ", error.isCancelled)
        }.finally {
            if let res = response {
                self.presenter?.presentCategories(response: res)
            }
        }
    }
}
