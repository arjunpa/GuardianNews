//
//  RemoteDataManager.swift
//  Headlines
//
//  Created by Arjun P A on 26/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import Alamofire

final class RemoteDataManager {
    
    let sessionManager: Alamofire.SessionManager
    
    init(sessionManager: Alamofire.SessionManager = Alamofire.SessionManager.default) {
        self.sessionManager = sessionManager
    }
    
    func request(httpMethod: HTTPMethod = .get,
                 encoding: ParameterEncoding = URLEncoding.default,
                 parameters: Parameters? = nil,
                 headers: HTTPHeaders? = nil,
                 url: URL,
                 completionHandler: @escaping (Result<Any>) -> Void) {
        sessionManager.request(url,
                               method: httpMethod,
                               parameters: parameters,
                               encoding: encoding,
                               headers: headers)
                        .responseJSON { response in
            completionHandler(response.result)
        }
    }
}
