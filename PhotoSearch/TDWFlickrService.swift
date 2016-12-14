//
//  TDWFlickrService.swift
//  PhotoSearch
//
//  Created by Christian on 07/12/2016.
//  Copyright © 2016 TDW. All rights reserved.
//

import Foundation

import SwiftyJSON

class TDWFlickrService: NSObject, URLSessionDelegate, URLSessionDataDelegate {
    
    var apiKey:String? = nil;
    
    init(apiKey:String) {
        
        self.apiKey = apiKey
    }
    
    func search(_ term:String, page:Int, callback:@escaping (_ response:TDWFlickrSearchResponse?, _ error:Error?) -> Void) {
        
        call("GET",baseURL:"https://api.flickr.com/services/rest/?method=flickr.photos.search&tags=\(term)&per_page=20&page=\(page)") {(data, response, error) -> Void in
            
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
    
    func sizes(for imageID:String, callback:@escaping (_ response:TDWFlickrImageSizesResponse?, _ error:Error?) -> Void) {
        
        call("GET",baseURL:"https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&photo_id=\(imageID)") {(data, response, error) -> Void in
            
            if error != nil {
                
                callback(nil, error)
                
            } else {
                
                if let responseData = data {
                    
                    let json = JSON(data: responseData)
                    
                    let response = TDWFlickrImageSizesResponse(json: json)
                    
                    callback(response ,nil)
                    
                }
                
            }
        }
        
    }
    
    
    func call(_ method:String,baseURL:String, callback:@escaping (_ data:Data?, _ response:URLResponse?, _ error:Error?) -> Void) {
        
                
        guard let url =  URL(string: "\(baseURL)&api_key=\(self.apiKey!)&format=json&nojsoncallback=1" ) else {
            
            callback(nil,nil,NSError(domain: "photosearch.nourl", code: 0, userInfo: nil))
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

