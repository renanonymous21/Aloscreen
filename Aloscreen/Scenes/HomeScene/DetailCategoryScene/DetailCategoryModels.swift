//
//  DetailCategoryModels.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct DetailData: Codable {
    let results: [ResultData]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

struct ResultData: Codable {
    let urls: ResultURLS
    
    enum CodingKeys: String, CodingKey {
        case urls = "urls"
    }
}

struct ResultURLS: Codable {
    let small: String
    
    enum CodingKeys: String, CodingKey {
        case small = "small"
    }
}


enum DetailCategory {
  // MARK: Use cases
  
    enum FetchPictures {
        struct Request {
            var page: Int
            var query: String
        }
        struct Response {
            var data: DetailData
        }
        struct ViewModel {
            var show: DetailData
        }
    }
}
