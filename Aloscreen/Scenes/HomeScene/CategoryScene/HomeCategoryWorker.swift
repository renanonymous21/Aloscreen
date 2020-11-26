//
//  HomeCategoryWorker.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import PromiseKit

class HomeCategoryWorker {
    func fetchCategories(request: HomeCategory.FetchCategory.Request) -> Promise<[Category]> {
        return APIManager.request(PhotosEndpoints.getListCategory(request: request), dataReturnType: [Category].self)
    }    
}
