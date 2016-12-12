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
        
        guard let path = Bundle.main.path(forResource: "APIKey", ofType: "plist") else {
            
            callback(nil,nil,NSError(domain: "photosearch.nokeystorepath", code: 1, userInfo: nil));
            return
        }
        
        guard let keyStore = NSDictionary(contentsOfFile:  path) else {
            
            callback(nil,nil,NSError(domain: "photosearch.nokeystore", code: 2, userInfo: nil));
            return
        }
        
        //This isnt great, will update to something better
        guard let flickrAPIKey = keyStore["FlickrAPIKey"] else {
            
            callback(nil,nil,NSError(domain: "photosearch.nokey", code: 3, userInfo: nil));
            return
        }
        
        guard let url =  URL(string: "\(baseURL)&api_key=\(flickrAPIKey)&tags=kitten&format=json&nojsoncallback=1" ) else {
            
            callback(nil,nil,NSError(domain: "photosearch.nourl", code: 4, userInfo: nil))
            return
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

