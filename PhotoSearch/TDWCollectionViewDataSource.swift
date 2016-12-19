//
//  TDWCollectionViewDataSource.swift
//  PhotoSearch
//
//  Created by Christian on 07/12/2016.
//  Copyright © 2016 TDW. All rights reserved.
//

import UIKit

class TDWCollectionViewDataSection: NSObject {
    
    let identifier : String
    
    var items : [TDWCollectionViewCellData]
    
    init(identifier:String, items : [TDWCollectionViewCellData]) {
        
        self.identifier = identifier
        
        self.items = items
    }
}

class TDWCollectionViewCellData: NSObject {
    
    let identifier : String
    
    let size : CGSize
    
    init(identifier:String, size:CGSize) {
        
        self.identifier = identifier
        
         self.size = size;
    }
    
    init<CellClass>(cellClass:CellClass.Type, size:CGSize) {

        self.identifier = String(describing: cellClass)
        
        self.size = size;
    }
}

class TDWCollectionViewImageCellData: TDWCollectionViewCellData {
    
    var imageTitle : String?
    
    var image : UIImage?
    
    var imageLoader:TDWImageLoader?
    
    var url: String?
    
    init(identifier:String, size:CGSize, imageTitle:String? = nil, image:UIImage? = nil, imageLoader:TDWImageLoader? = nil) {
        
        self.imageTitle = imageTitle
        
        self.image = image
        
        self.imageLoader = imageLoader
        
        super.init(identifier: identifier, size: size)
    }
    
    init<CellClass>(cellClass:CellClass.Type, size:CGSize, imageTitle:String? = nil, image:UIImage? = nil, imageLoader:TDWImageLoader? = nil) {
        
        self.imageTitle = imageTitle
        
        self.image = image
        
        self.imageLoader = imageLoader
        
        super.init(cellClass: cellClass, size: size)
    }

}

class TDWCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    var sectionData : [TDWCollectionViewDataSection]!
    
    init(sectionData:[TDWCollectionViewDataSection]) {
        
        self.sectionData = sectionData
    }
    
    func updateSections(_ sectionData:[TDWCollectionViewDataSection]) {
         self.sectionData = sectionData
    }
    
    func indexPathOfObject(_ cellData:TDWCollectionViewCellData) -> IndexPath? {
        
        for section in sectionData {
            
            if let idx = section.items.index(of: cellData) {
                
                if idx != NSNotFound {
                    
                    return IndexPath(item: idx, section: sectionData.index(of: section)!)
                }
            }
        }
        
        return nil
    }
    
    func objectAtIndexPath(_ path:IndexPath) -> TDWCollectionViewCellData? {
        
        if path.section > sectionData.count  {
        
            return nil
        }
        
        if  path.item > sectionData[path.section].items.count  {
            
            return nil
        }
        
        return sectionData[path.section].items[path.item]
    }
    
    func insert(_ cellDatas:[TDWCollectionViewCellData], atIndex:Int,section:Int) -> [IndexPath] {
        
        let collectionSection = sectionData[section]
        
        collectionSection.items.insert(contentsOf: cellDatas, at: atIndex)
        
        let startIndex = atIndex
        
        var newPaths:[IndexPath] = [IndexPath]()
        
        for cellData in cellDatas {
            
            newPaths.append(IndexPath(row: startIndex + cellDatas.index(of: cellData)!, section: section))
        }
        
        
        
        return newPaths
    }
    
    func remove(_ items:[TDWCollectionViewCellData]) -> [IndexPath] {
        
        var newPaths:[IndexPath] = [IndexPath]()
        
        for item in items {
            
            for section in sectionData {
                
                if let idx =  section.items.index(of: item) {
                    
                    if idx != NSNotFound {
 
                        newPaths.append(IndexPath(row:idx, section: sectionData.index(of: section)!))
                    }
                }
            }
        }
        
        for item in items {
            
            for section in sectionData {
                
                if let idx =  section.items.index(of: item) {
                    
                    //var rows = [](section.rows);
                    
                    if idx != NSNotFound {
                        
                        section.items.remove(at: idx)
                        
                    }
                }
            }
        }
        return newPaths
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section > sectionData.count {
            
            return 0
        }
        return sectionData[section].items.count

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
         return sectionData.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cellData = objectAtIndexPath(indexPath) else {
            
            return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TDWCollectionViewCell()), for: indexPath)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellData.identifier, for: indexPath)
        
        if let cell = cell as? TDWImageCollectionViewCell {
        
            cell.cellData = cellData as? TDWCollectionViewImageCellData;
            
        }
        
        return cell;
    }
}
