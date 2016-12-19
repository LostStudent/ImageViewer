//
//  TDWSearchData.swift
//  PhotoSearch
//
//  Created by Christian on 19/12/2016.
//  Copyright © 2016 TDW. All rights reserved.
//

import UIKit

class TDWFlickrSearchData: NSObject {
    
    let service:TDWFlickrService
    
    var page = 1
    
    var searchTerm:String? = nil
    
    init(service:TDWFlickrService) {
        
        self.service = service
    }
    
    func search(term:String,completion:@escaping (_ photos:[TDWPhoto]?,_ error:Error?)->Void) {
        
        searchTerm = term
        
        page = 1
        
        if let term = searchTerm {
            
            fetchPage(term:term, page: page, completion:  completion)
            
        } else {
            
            completion(nil,NSError(domain: "TDWFlickrService.noSearchTerm", code: 0, userInfo: nil))
        }
    }
    
    func nextPage(completion:@escaping (_ photos:[TDWPhoto]?,_ error:Error?)->Void) {
        
        page += 1
        
        if let term = searchTerm {
        
            fetchPage(term:term, page: page, completion: completion)
            
        } else {
            
             completion(nil,NSError(domain: "TDWFlickrService.noSearchTerm", code: 0, userInfo: nil))
        }
    }
    
    func fetchPage(term:String, page:Int, completion:@escaping (_ photos:[TDWPhoto]?,_ error:Error?)->Void) -> Void {
        
        service.search(term,page: page) { (response, error) in
            
            if let err = error{
                
                print(err)
            }
            
            guard let response = response else {
                
                print("No Resp")
                
                return;
            }
            
            completion(response.photos.photo,nil)
            
        }
    }
    
    func sizes(for imageID:String, callback:@escaping (_ sizes:TDWSizes?, _ error:Error?) -> Void) {
        
        service.sizes(for: imageID) { (response, error) -> Void in
        
            if error != nil {
                
                print("error")
            }
            guard let response = response else {
                
                return
            }
            
            callback(response.sizes,nil)
        }
    }
}
