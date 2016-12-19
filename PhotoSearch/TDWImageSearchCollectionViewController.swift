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
    
    var searchData : TDWFlickrSearchData? {
        
         didSet {
            
            if let searchData = searchData ,let _ = collectionView {
                
                searchData.search(term: "Kittens", completion: self.generateCellData)
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
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
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateCellData(photos:[TDWPhoto]?, error:Error?) -> Void {
        
        guard let photos = photos else {
            
            return
        }
        
        let width = (self.collectionView?.frame.size.width)!
        
        var collectionViewSectionRows = [TDWCollectionViewImageCellData]()
        
        for imageData in photos {
            
            guard let id = imageData.id else {
                
                print("no url params")
                
                continue
            }
            
            
            
            let cellData = TDWCollectionViewImageCellData(identifier: "TDWImageCollectionViewCell", size: CGSize(width: width/2, height: width/2 ),imageTitle:imageData.title,imageLoader:TDWImageLoader())
            
            collectionViewSectionRows.append(cellData)
            
            self.searchData?.sizes(for: id, callback: { (sizes, error) in
                
                if error != nil {
                    
                    print("error")
                }
                guard let sizes = sizes else {
                    
                    return
                }
                
                let size = sizes.size?.first(where: { (size) -> Bool in
                    
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
            
            searchData?.nextPage(completion: self.generateCellData)
            
        }
    }

    
}
