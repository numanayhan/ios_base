//
//  RequestService.swift
//  iBase
//
//  Created by Numan Ayhan on 12.08.2021.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift

class RequestService {
    
    func genericRequest<M:Decodable>(_ url: String, method: HTTPMethod = .get, parameters: Parameters? = nil,
                 encoding: ParameterEncoding = URLEncoding.queryString, headers: HTTPHeaders? = nil,
                 interceptor: RequestInterceptor? = nil, completion: @escaping(M) ->Void) {
       
        
    }
}
