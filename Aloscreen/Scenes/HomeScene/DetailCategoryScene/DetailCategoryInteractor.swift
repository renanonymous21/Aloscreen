//
//  DetailCategoryInteractor.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailCategoryBusinessLogic {
    func getDetailPictures(request: DetailCategory.FetchPictures.Request)
}

protocol DetailCategoryDataStore {
    var detailData: DetailData? { get set }
}



class DetailCategoryInteractor: DetailCategoryBusinessLogic, DetailCategoryDataStore {
    var presenter: DetailCategoryPresentationLogic?
    var worker: DetailCategoryWorker?
    var detailData: DetailData?
    // MARK: Do something

    func getDetailPictures(request: DetailCategory.FetchPictures.Request) {
        worker = DetailCategoryWorker()
        var response: DetailCategory.FetchPictures.Response?
        worker?.fetchDetailPictures(request: request).done {
            detail in
            
            self.detailData = detail
            response = DetailCategory.FetchPictures.Response(data: detail)
        }.catch(policy: .allErrors) {
            error in
            alert.showMessage(title: "Oops", msg: error.localizedDescription)
            print("ERROR: ", error.localizedDescription,  "IS CANCELLED: ", error.isCancelled)
        }.finally {
            if let res = response {
                self.presenter?.presentDetailPictures(response: res)
            }
        }        
    }
}
