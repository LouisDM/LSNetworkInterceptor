//
//  CodeInjectionSwift.swift
//  NetworkInterceptorExample
//
//  Created by Kenneth Poon on 23/7/18.
//  Copyright © 2018 Kenneth Poon. All rights reserved.
//

import Foundation

@objc public class CodeInjectionSwift: NSObject {
    
    @objc public static let shared = CodeInjectionSwift()
    
    override private init(){}
    
    lazy var fileManger:FileManager=FileManager.default
    
    @objc public func performTask(){
        
        var data : [[String : String]] = []
        
        let filePath = Bundle(for: type(of: self)).path(forResource: "requestRedirector", ofType: "plist")
        
        print("filePath:\(filePath!)")
        
        if (FileManager.default.fileExists(atPath: filePath!))  {
        
            let contentA = NSArray(contentsOfFile: filePath!)
            
            let dic :[[String:String]] = contentA as! [[String : String]]
            
            data = dic
            
            print("data:\(data)")
        }
        
        var requestRedirectors = Array<RequestRedirector>()
                    
        for dic in data {
            
            for (domain,url) in dic {
                
                print("domain:\(domain):\(url)")
                
                requestRedirectors.append(RequestRedirector(requestEvaluator: DomainHttpRequestEvaluator(domain: domain), redirectableRequestHandler: AlternateUrlRequestRedirector(url: URL(string: url)!)))
            }
            
        }
        
        print("requestRedirectors:\(requestRedirectors.count)")
        
        let requestSniffers: [RequestSniffer] = [
            RequestSniffer(requestEvaluator: AnyHttpRequestEvaluator(), handlers: [
                SniffableRequestHandlerRegistrable.console(logginMode: .nslog).requestHandler()
            ])
        ]
        
        //            let requestRedirectors: [RequestRedirector] = [
        //                RequestRedirector(requestEvaluator: DomainHttpRequestEvaluator(domain: "www.antennahouse.com"), redirectableRequestHandler: AlternateUrlRequestRedirector(url: URL(string: "https://www.rhodeshouse.ox.ac.uk/media/1002/sample-pdf-file.pdf")!))
        //            ]
        
        let networkConfig = NetworkInterceptorConfig(requestSniffers: requestSniffers,
                                                     requestRedirectors: requestRedirectors)
        NetworkInterceptor.shared.setup(config: networkConfig)
        NetworkInterceptor.shared.startRecording()
        
    }
}
