//
//  TDWImageSearchCollectionViewController.swift
//  PhotoSearch
//
//  Created by Christian on 08/12/2016.
//  Copyright © 2016 TDW. All rights reserved.
//

import UIKit

class TDWImageSearchCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, TDWSearchDataProviderDelegate {

    var collectionViewDataSource : TDWCollectionViewDataSource? = nil
    
    var searchData : TDWSearchDataProvider? {
        
         didSet {
            
            if let searchData = searchData ,let _ = collectionView {
                
                self.searchData?.delegate = self
                
                searchData.search(term: "Kittens", completion: self.didRecieveData)
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionViewDataSource = TDWCollectionViewDataSource(sectionData: [
            TDWCollectionViewDataSection(identifier:"imageSection",
                items:  [TDWCollectionViewImageCellData(identifier:"TDWImageCollectionViewCell")])
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let cellData = collectionViewDataSource?.objectAtIndexPath(indexPath) else {
            
            return CGSize.zero
        }
        
        return CGSize(width: collectionView.frame.size.width/2, height: 200)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.zero
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let scrollY = scrollView.contentSize.height - scrollView.contentOffset.y;
        
        let diff = scrollY - scrollView.frame.size.height;
        
        if (diff < 10) {
            
            searchData?.nextPage(completion: self.didRecieveData)
            
        }
    }

    func didRecieveData(cellData:[TDWCollectionViewImageCellData]?,error:Error?) -> Void {
        
        guard let cellData = cellData else {
            return
        }
        
        if let idx = self.collectionViewDataSource?.sectionData[0].items.count {
            
            if let paths = self.collectionViewDataSource?.insert(cellData, atIndex: idx-1, section: 0) {
                
                self.collectionView?.insertItems(at: paths)
            }
        }
    }
    
    func didUpdateData(cellData:[TDWCollectionViewImageCellData]?,error:Error?) -> Void {
        
        guard let cellData = cellData else {
            return
        }
        
        var updatedPaths = [IndexPath]()
        
        for cellData in cellData {
            
            if let path = self.collectionViewDataSource?.indexPathOfObject(cellData) {
                
                updatedPaths.append(path)
            }
        }
        
        self.collectionView?.reloadItems(at: updatedPaths)
    }
}
