//
//  APIManager.swift
//  Aloscreen
//
//  Created by Rendy K.R on 26/11/20.
//

import Moya
import PromiseKit

protocol APIServiceProtocol {
    static func request<T: TargetType, U: Decodable>(_ target: T, dataReturnType: U.Type, test: Bool, debugMode: Bool) -> Promise<U>
}

struct APIManager: APIServiceProtocol {
    static func request<endPoint: TargetType, returnedObject: Decodable>(_ endpoint: endPoint, dataReturnType: returnedObject.Type, test: Bool = false, debugMode: Bool = false) -> Promise<returnedObject> {
        
        let provider = test ? (MoyaProvider<endPoint>(stubClosure: MoyaProvider.immediatelyStub)) : (debugMode ? MoyaProvider<endPoint>(plugins: [NetworkLoggerPlugin()]) : MoyaProvider<endPoint>())
        
        return Promise {
            data in
            
            provider.request(endpoint) {
                result in

                switch result {
                case let .success(response):
                    let decoder = JSONDecoder()
                    do {
                        let results = try decoder.decode(returnedObject.self, from: response.data)
                        data.fulfill(results)
                    } catch {
                        data.reject(error)
                    }
                case let .failure(error):
                    data.reject(error)
                }
            }
        }
    }
}
