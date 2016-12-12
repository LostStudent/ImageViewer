//
//  TDWFlickrService.swift
//  PhotoSearch
//
//  Created by Christian on 07/12/2016.
//  Copyright © 2016 TDW. All rights reserved.
//

import Foundation

import SwiftyJSON

class TDWFlickrService: NSObject, URLSessionDelegate, URLSessionTaskDelegate {

    //Key:
    //47e7823406de7525a3da6fe36aad5ca1
    
    //Secret:
    //3e4933a1f16615c8de7525a3da6fe36aad5ca1
    
    func search(_ term:String, callback:@escaping (_ response:TDWFlickrSearchResponse?, _ error:Error?) -> Void) {
        
        call("GET",baseURL:"https://api.flickr.com/services/rest/?method=flickr.photos.search") {(data, response, error) -> Void in
            
            if error != nil {
                
                callback(nil, nil)
                
            } else {
                
                if let responseData = data {
                    
                    let json = JSON(data: responseData)
                    
                    let response = TDWFlickrSearchResponse(fromJson: json)
                    
                    callback(response ,nil)
                    
                }
                
            }
        }
        
    }
    
    
    func call(_ method:String,baseURL:String, callback:@escaping (_ data:Data?, _ response:URLResponse?, _ error:Error?) -> Void) {
        
        Bundle.main.path(forResource: "APIKey", ofType: ".plist")
        
        let compiledURL = URL(string: "\(baseURL)&api_key=\(flickrAPIKey)&tags=kitten&format=json&nojsoncallback=1" )
        
        guard let url = compiledURL else {
            
            callback(nil,nil,NSError(domain: "photosearch", code: 0, userInfo: nil));
                return;
        }
        
         var request = URLRequest(url:url);
        
        request.httpMethod = method;
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let configuration =
            URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration,
                                   delegate: self,
                                   delegateQueue:OperationQueue.main)
        
        let task = session.dataTask(with: request, completionHandler:callback)
        
        task.resume()
    }
}

