//
//  BaseAPIRouter.swift
//  MagicApp
//
//  Created by Cường Trần on 12/10/2023.
//

import Alamofire
import PromiseKit
import RxSwift

enum APIError: Error {
    case invalidURL
    case requestFailed
    // Add more error cases as needed
}

enum CustomHTTPMethod: String {
    case get = "GET"
    case post = "POST"
    // Add more HTTP methods as needed
}

protocol BaseAPIRouter {
    var baseURL: String { get }
    var path: String { get }
    var method: CustomHTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: HTTPHeaders? { get }
}

extension BaseAPIRouter {
    
    var baseURL: String {
        return "https://" // Replace with your API base URL
    }
    
    var headers: HTTPHeaders? {
        return nil // Add custom headers if needed
    }
    
    func request() -> Promise<[String: Any]> {
        return Promise { seal in
            guard let url = URL(string: baseURL + path) else {
                seal.reject(APIError.invalidURL)
                return
            }
            
            AF.request(url, method: Alamofire.HTTPMethod(rawValue: method.rawValue), parameters: parameters, headers: headers)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        if let json = value as? [String: Any] {
                            seal.fulfill(json)
                        } else {
                            seal.reject(APIError.requestFailed)
                        }
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
        }
    }
    
    func requestObservable() -> Observable<[String: Any]> {
        return Observable.create { observer in
            self.request().done { json in
                observer.onNext(json)
                observer.onCompleted()
            }.catch { error in
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
}

struct YoutubeRouter: BaseAPIRouter {
    var input: String
    var path: String = "/search"
    
    init(input: String) {
        self.input = input
    }
    
    var method: CustomHTTPMethod = .get
    
    var parameters: [String : Any]? = [
        "part": "snippet",
        "maxResults": 10,
        "q": "domixi",
        "key": "AIzaSyCOyEn-gMI3ldLb_G-nh2tRWsIpOEhngHo"
    ]
}
