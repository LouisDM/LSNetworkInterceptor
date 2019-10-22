//
//  DomainHttpRequestEvaluator.swift
//  NetworkInterceptor
//
//  Created by Kenneth Poon on 26/8/18.
//  Copyright © 2018 Kenneth Poon. All rights reserved.
//

import Foundation

public class DomainHttpRequestEvaluator: RequestEvaluator {
    let domain: String
    public init(domain: String){
        self.domain = domain
    }
    
    public func isActionAllowed(urlRequest: URLRequest) -> Bool {
        guard AnyHttpRequestEvaluator().isActionAllowed(urlRequest: urlRequest) else {
            return false
        }
        
        guard let absoluteString = urlRequest.url?.absoluteString else {
            return false
        }
        
        
        if absoluteString.contains(self.domain) {
            
            print("absoluteString:\(absoluteString)")
            
            UserDefaults.standard.set(absoluteString, forKey: "DomainHttpRequestEvaluatorAbsoluteString")
            UserDefaults.standard.set(self.domain, forKey: "DomainHttpRequestEvaluatorDomain")
            return true
        }
        
//        guard let host = urlRequest.url?.host else {
//            return false
//        }
//
//        if host == self.domain {
//            return true
//        }
//
//        guard let scheme = urlRequest.url?.scheme else {
//            return false
//        }
//
//        let schemeHost = "\(scheme)://\(host)"
//
//        UserDefaults.standard.set(schemeHost, forKey: "DomainHttpRequestEvaluatorSchemeHost")
//
//        let mutableRequest = (urlRequest as NSURLRequest).mutableCopy() as! NSMutableURLRequest
//
//        guard let path = mutableRequest.url?.path else {
//            return false
//        }
//
//        if path == self.domain {
//            return true
//        }
        
        return false
    }
}
