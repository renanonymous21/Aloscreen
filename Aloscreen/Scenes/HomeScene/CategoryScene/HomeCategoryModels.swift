//
//  HomeCategoryModels.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct Category: Codable {
    let id: String
    let title: String
    let preview_photos: [PreviewPhoto]
    let tags: [CategoryTags]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case preview_photos = "preview_photos"
        case tags = "tags"
    }
}

struct PreviewPhoto: Codable {
    let urls: PhotoUrls
    
    enum CodingKeys: String, CodingKey {
        case urls = "urls"
    }
}

struct PhotoUrls: Codable {
    let small: String
    
    enum CodingKeys: String, CodingKey {
        case small = "small"
    }
}

struct CategoryTags: Codable {
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
    }
}

enum HomeCategory {
  // MARK: Use cases

    enum FetchCategory {
        struct Request {
            var page: Int
        }
        struct Response {
            var data: [Category]
        }
        struct ViewModel {
            var show: [Category]
        }
    }
}
