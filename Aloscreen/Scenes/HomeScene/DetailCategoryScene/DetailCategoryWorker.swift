//
//  DetailCategoryWorker.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import PromiseKit

class DetailCategoryWorker {
    func fetchDetailPictures(request: DetailCategory.FetchPictures.Request) -> Promise<DetailData> {
        return APIManager.request(PhotosEndpoints.getLisPhotos(request: request), dataReturnType: DetailData.self)
    }
}
