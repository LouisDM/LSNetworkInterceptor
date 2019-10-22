//
//  AlternateUrlRequestRedirector.swift
//  NetworkInterceptor
//
//  Created by Kenneth Poon on 26/8/18.
//  Copyright © 2018 Kenneth Poon. All rights reserved.
//

import Foundation

public class AlternateUrlRequestRedirector: RedirectableRequestHandler {
    
    let url: URL
    
    public init(url: URL){
        self.url = url
    }
    
    public func redirectedRequest(originalUrlRequest: URLRequest) -> URLRequest {
        let mutableRequest = (originalUrlRequest as NSURLRequest).mutableCopy() as! NSMutableURLRequest
        
        let absoluteString = UserDefaults.standard.object(forKey: "DomainHttpRequestEvaluatorAbsoluteString") as! String
        let domain = UserDefaults.standard.object(forKey: "DomainHttpRequestEvaluatorDomain") as! String
        
        guard let range = absoluteString.range(of: domain) else { return mutableRequest as URLRequest}
        
        let newUrl = absoluteString.replacingCharacters(in: range, with: self.url.absoluteString)
        
        print("newUrl:\(newUrl)")
        
        mutableRequest.url = URL.init(string: newUrl)
        
        return mutableRequest as URLRequest
    }
}
