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
    
    var page = 1
    
    var term = "kitten"
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        fetchPage(page: page)
    }
    
    func fetchPage(page:Int) -> Void {
        
        guard let path = Bundle.main.path(forResource: "APIKey", ofType: "plist") else {
            
            return
        }
        
        guard let keyStore = NSDictionary(contentsOfFile:  path) else {
            
            return
        }
        
        guard let flickrAPIKey = keyStore["FlickrAPIKey"] as? String else {
            
            return
        }
    
        TDWFlickrService(apiKey:flickrAPIKey).search(term,page: page) { (response, error) in
            
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
                
                guard let id = imageData.id else {
                    
                    print("no url params")
                    
                    continue
                }

                let cellData = TDWCollectionViewImageCellData(identifier: "TDWImageCollectionViewCell", size: CGSize(width: width/2, height: width/2 ),imageTitle:imageData.title,imageLoader:TDWImageLoader())
                
                collectionViewSectionRows.append(cellData)
                
                TDWFlickrService(apiKey:flickrAPIKey).sizes(for: id, callback: { (response, error) in
                    
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
                    
                        if let indexPath = self.collectionViewDataSource?.indexPathOfObject(cellData) {
                            
                            self.collectionView!.reloadItems(at: [indexPath])
                        }
                        
                    }, completed: { (data, response, error) in
                        
                        if let error = error {
                            
                            print(error)
                        }
                        
                        guard let data = data else {

                            return();
                        }
                        
                        cellData.image = UIImage(data: data)
                        
                        if let indexPath = self.collectionViewDataSource?.indexPathOfObject(cellData) {
                            
                            self.collectionView!.reloadItems(at: [indexPath])
                            
                        }
                        
                        cellData.imageLoader = nil
                        
                        return();
                        
                    })
                
                  })
            }

            if let idx = self.collectionViewDataSource?.sectionData[0].items.count {
                
                if let paths = self.collectionViewDataSource?.insert(collectionViewSectionRows, atIndex: idx-1, section: 0)         {
                    
                    self.collectionView?.insertItems(at: paths)
                }

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
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let scrollY = scrollView.contentSize.height - scrollView.contentOffset.y;
        
        let diff = scrollY - scrollView.frame.size.height;
        
        if (diff < 10) {
            
            page+=1
            
            fetchPage(page: page)
            
        }
    }

    
}
