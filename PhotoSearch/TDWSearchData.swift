//
//  TDWSearchData.swift
//  PhotoSearch
//
//  Created by Christian on 19/12/2016.
//  Copyright © 2016 TDW. All rights reserved.
//

import UIKit

protocol TDWSearchDataProviderDelegate {
    
    func didUpdateData(cellData:[TDWCollectionViewImageCellData]?,error:Error?) -> Void
}

protocol TDWSearchDataProvider {
    
    var delegate:TDWSearchDataProviderDelegate? { get set }
    
    func search(term:String,completion:@escaping (_ photos:[TDWCollectionViewImageCellData]?,_ error:Error?)->Void)
    
    func nextPage(completion:@escaping (_ photos:[TDWCollectionViewImageCellData]?,_ error:Error?)->Void)
}

class TDWFlickrSearchData: NSObject, TDWSearchDataProvider {
    
    let service:TDWFlickrService
    
    var delegate:TDWSearchDataProviderDelegate? = nil
    
    var page = 1
    
    var searchTerm:String? = nil
    
    init(service:TDWFlickrService) {
        
        self.service = service
    }
    
    func search(term:String,completion:@escaping (_ photos:[TDWCollectionViewImageCellData]?,_ error:Error?)->Void) {
        
        searchTerm = term
        
        page = 1
        
        if let term = searchTerm {
            
            fetchPage(term:term, page: page, completion:  completion)
            
        } else {
            
            completion(nil,NSError(domain: "TDWFlickrService.noSearchTerm", code: 0, userInfo: nil))
        }
    }
    
    func nextPage(completion:@escaping (_ photos:[TDWCollectionViewImageCellData]?,_ error:Error?)->Void) {
        
        page += 1
        
        if let term = searchTerm {
        
            fetchPage(term:term, page: page, completion: completion)
            
        } else {
            
            completion(nil,NSError(domain: "TDWFlickrService.noSearchTerm", code: 0, userInfo: nil))
        }
    }
    
    func fetchPage(term:String, page:Int, completion:@escaping (_ photos:[TDWCollectionViewImageCellData]?,_ error:Error?)->Void) -> Void {
        
        service.search(term,page: page) { (response, error) in
            
            if let err = error{
                
                print(err)
            }
            
            guard let response = response else {
                
                print("No Resp")
                
                return;
            }
            
            completion(self.generateCellData(photos: response.photos.photo),nil)
            
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
    
    func generateCellData(photos:[TDWPhoto]?) -> [TDWCollectionViewImageCellData]? {
        
        guard let photos = photos else {
            
            return nil
        }
        
        var imageCellData = [TDWCollectionViewImageCellData]()
        
        for imageData in photos {
            
            guard let id = imageData.id else {
                
                print("no url params")
                
                continue
            }
            
            let cellData = TDWCollectionViewImageCellData(identifier: "TDWImageCollectionViewCell",imageTitle:imageData.title,imageLoader:TDWImageLoader())
            
            imageCellData.append(cellData)
            
            service.sizes(for: id, callback: { (response, error) in
                
                if error != nil {
                    
                    print("error")
                }
                guard let response = response else {
                    
                    return
                }
                
                let size = response.sizes?.size?.first(where: { (size) -> Bool in
                    
                    return size.label == "Large Square"
                })
                
                guard let url = size?.source else {
                    
                    return
                }
                
                cellData.imageLoader?.downloadImage(url,progress: {(recieved,total) in
                    
                    self.delegate?.didUpdateData(cellData: [cellData], error: nil)
                    
                }, completed: { (data, response, error) in
                    
                    if let error = error {
                        
                        print(error)
                    }
                    
                    guard let data = data else {
                        
                        return();
                    }
                    
                    cellData.image = UIImage(data: data)
                    
                    cellData.imageLoader = nil
                    
                    self.delegate?.didUpdateData(cellData: [cellData], error: nil)
                    
                    return();
                    
                })
                
            })
        }
        
        return imageCellData
    }
}
