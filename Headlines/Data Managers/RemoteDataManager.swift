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
    
    private let sessionManager: Alamofire.SessionManager
    
    /**
     Initialize the manager with a session object. Defauls to the default session.
    
     - Parameter sessionManager: The session manager.
    */
    init(sessionManager: Alamofire.SessionManager = Alamofire.SessionManager.default) {
        self.sessionManager = sessionManager
    }
    
    /**
     Make a request to a web service with given parameters.
    
     - Parameters:
       - httpMethod: The HTTP method to be used.
       - encoding: The parameter encoder. Defaults to URLEncoding.
       - parameters: The parameters to be send in the body of the request
       - headers: The headers.
       - url: The URL to the web service
       - completionHandler: The completion handler.
    */
    func request(httpMethod: HTTPMethod = .get,
                 encoding: ParameterEncoding = URLEncoding.default,
                 parameters: Parameters? = nil,
                 headers: HTTPHeaders? = nil,
                 url: URL,
                 completionHandler: @escaping (Result<Data>) -> Void) {
        self.sessionManager.request(url,
                               method: httpMethod,
                               parameters: parameters,
                               encoding: encoding,
                               headers: headers)
                      .responseData { data in
                         completionHandler(data.result)
        }
    }
}
