//
//  PhotosEndpoints.swift
//  Aloscreen
//
//  Created by Rendy K.R on 26/11/20.
//

import Moya

enum PhotosEndpoints {
    case getListCategory(request: HomeCategory.FetchCategory.Request)
    case getLisPhotos(request: DetailCategory.FetchPictures.Request)
}

extension PhotosEndpoints: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.unsplash.com")!
    }
    
    var path: String {
        
        switch self {
        case .getLisPhotos:
            return "/search/photos"
        case .getListCategory:
            return "/collections"
        }
    }
    
    var method: Method {
        switch self {
        case .getLisPhotos:
            return .get
        case .getListCategory:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        var urlParams: Dictionary<String, Any> = [:]
        switch self {
        case .getLisPhotos(let request):
            urlParams["page"] = request.page
            urlParams["query"] = request.query
            return .requestParameters(parameters: urlParams, encoding: URLEncoding.queryString)
        case .getListCategory(let request):
            urlParams["page"] = request.page
            return .requestParameters(parameters: urlParams, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        let authHeaders = [
            "Authorization": "Client-ID VOywBQHN_5CrRn0UlAZRubtq2OvcsngFtFbEP2bYFug"
        ]
        switch self {
        case .getListCategory:
            return authHeaders
        case .getLisPhotos:
            return authHeaders
        }
    }
    
    
}
