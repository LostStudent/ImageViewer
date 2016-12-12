//
//  TDWImageLoader.swift
//  PhotoSearch
//
//  Created by Christian on 08/12/2016.
//  Copyright © 2016 TDW. All rights reserved.
//

import UIKit

class TDWImageLoader: NSObject, URLSessionDelegate, URLSessionTaskDelegate {
    
    func downloadImage(_ baseURL:String, callback:@escaping (_ data:Data?, _ response:URLResponse?, _ error:Error?) -> Void) {
        
       
        
        guard let url = URL(string: "\(baseURL)&api_key=47e7823406de7525a3da6fe36aad5ca1" ) else {
            
            callback(nil,nil,NSError(domain: "photosearch", code: 0, userInfo: nil));
            return;
        }
        
        var request = URLRequest(url:url);
        
        request.httpMethod = "GET";
        
        //var
        
        let configuration =
            URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration,
                                   delegate: self,
                                   delegateQueue:OperationQueue.main)
        
        //let task = session.dataTask(with: request, completionHandler:callback)
        
        let task = session.dataTask(with: request, completionHandler: callback)
        
        task.resume()
    }
}
