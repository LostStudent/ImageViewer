//
//  TDWImageSearchCollectionViewController.swift
//  PhotoSearch
//
//  Created by Christian on 08/12/2016.
//  Copyright © 2016 TDW. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TDWImageSearchCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var collectionViewDataSource : TDWCollectionViewDataSource? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    
        // Register cell classes
        //self.collectionView!.registerClass(TDWImageCollectionViewCell.self, forCellWithReuseIdentifier: String(TDWImageCollectionViewCell))
        
        collectionViewDataSource = TDWCollectionViewDataSource(sectionData: [
            TDWCollectionViewDataSection(identifier:"imageSection",
                items:  [TDWCollectionViewImageCellData(identifier:"TDWImageCollectionViewCell",size: CGSize(width: (collectionView?.frame.size.width)!, height: 200)
            )])
        ])
        
        self.collectionView?.dataSource = collectionViewDataSource
        
        self.collectionView?.reloadData()
        
        self.collectionView?.collectionViewLayout = UICollectionViewFlowLayout()
        
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 0
        
        layout.minimumInteritemSpacing = 0
        
        //Get the API Key from a resource file
        
        guard let path = Bundle.main.path(forResource: "APIKey", ofType: "plist") else {
            
            return
        }
        
        guard let keyStore = NSDictionary(contentsOfFile:  path) else {
            
            return
        }
        
        guard let flickrAPIKey = keyStore["FlickrAPIKey"] as? String else {
            
            return
        }

        //continue to make call
        TDWFlickrService(apiKey:flickrAPIKey).search("kitten") { (response, error) in
            
            if let err = error{
                
                print(err)
            }
            
            guard let response = response else {
                
                print("No Resp")
                
                return;
                
            }
            
            var collectionViewSectionRows = [TDWCollectionViewImageCellData]()
            
            let width = (self.collectionView?.frame.size.width)!
            
            for imageData in response.photos.photo {
                
                guard let farm = imageData.farm, let server = imageData.server, let id = imageData.id, let secret = imageData.secret else {
                    
                    print("no url params")
                    
                    continue
                }

                let cellData = TDWCollectionViewImageCellData(identifier: "TDWImageCollectionViewCell", size: CGSize(width: width/2, height: width/2 ),imageTitle:imageData.title,imageLoader:TDWImageLoader())
                
                collectionViewSectionRows.append(cellData)
                
                cellData.imageLoader?.downloadImage("https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg", callback: { (data, response, error) in
                    
                    if let error = error {
                        
                        print(error)
                    }
                    
                    guard let data = data else {
                        
                        print("No Data")
                        
                        return();
                    }
                    
                    cellData.image = UIImage(data: data)
                    
                    if let indexPath = self.collectionViewDataSource?.indexPathOfObject(cellData) {
                        
                        self.collectionView!.reloadItems(at: [indexPath])
                        
                    }
                    
                    cellData.imageLoader = nil
                    
                    return();
                    
                })
            }
            
            if let paths = self.collectionViewDataSource?.insert(collectionViewSectionRows, atIndex: 0, section: 0) {
            
                self.collectionView?.insertItems(at: paths)
                
            }
            
        }
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let cellData = collectionViewDataSource?.objectAtIndexPath(indexPath) else {
            
            return CGSize.zero
        }
        
        return cellData.size

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    
    
}
