//
//  TDWImageLoader.swift
//  PhotoSearch
//
//  Created by Christian on 08/12/2016.
//  Copyright © 2016 TDW. All rights reserved.
//

import UIKit

class TDWImageLoader: NSObject, URLSessionDelegate, URLSessionDataDelegate {
    
    var task : URLSessionDataTask? = nil
    
    var progress : ((Int64,Int64) -> Void)? = nil
    
    var completed : ((Data?, URLResponse?, Error?) -> Void)? = nil
    
    var returnedData : Data? = nil
    
     var session : URLSession? = nil
    
    func getProgress() -> (recieved:Int64,total:Int64)? {
        
        guard let t = task else {
            
            return nil
        }
        
        return (recieved:t.countOfBytesReceived, total:t.countOfBytesExpectedToReceive)
    }
    
    func downloadImage(_ baseURL:String, progress:@escaping (_ recieved:Int64,_ total:Int64) -> Void, completed:@escaping (_ data:Data?, _ response:URLResponse?, _ error:Error?) -> Void) {
        
        guard let url = URL(string: "\(baseURL)" ) else {
            
            completed(nil,nil,NSError(domain: "photosearch", code: 0, userInfo: nil));
            return;
        }
        
        var request = URLRequest(url:url);
        
        request.httpMethod = "GET";
        
        self.completed = completed
        
        self.progress = progress
        
        let configuration =
            URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration,
                                   delegate: self,
                                   delegateQueue:OperationQueue.main)
        
        kdebug_signpost_start(5, 0, 0, 0, 0)
        
        task = session.dataTask(with: request)
    
        task?.resume()
    }

    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Swift.Void) {
        
        completionHandler(.allow)
        
        if let progress = progress {
            
            progress(dataTask.countOfBytesReceived, dataTask.countOfBytesExpectedToReceive)
        }
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
        if var newData = returnedData {
            
             newData.append(data)
            
        } else {
            
            returnedData = data
        }
        
        if let progress = progress {
            
             progress(dataTask.countOfBytesReceived, dataTask.countOfBytesExpectedToReceive)
        }
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        if let completed = completed {
        
            completed(returnedData, task.response, error)
        }
        
        session.invalidateAndCancel()
        
         kdebug_signpost_end(5, 0, 0, 0, 0)
    }
}
