//
//  TDWImageCollectionViewCell.swift
//  PhotoSearch
//
//  Created by Christian on 07/12/2016.
//  Copyright © 2016 TDW. All rights reserved.
//

import UIKit

class TDWCollectionViewCell: UICollectionViewCell {
    
     var cellData: TDWCollectionViewImageCellData? = nil
}

class TDWImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageTitle: UILabel!
    
    let identifier = "TDWImageCollectionViewCell"
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var cellData: TDWCollectionViewImageCellData? {
        
        didSet {
            
            guard let cellData = cellData else {
                
                return
            }
            
            if let title = cellData.imageTitle {
                
                imageTitle.isHidden = false
                
                imageTitle.text = title
                
            } else {
                
                imageTitle.isHidden = true
            }
            
            if let image = cellData.image {
                
                loadingIndicator.stopAnimating()
                
                imageView.image = image
                
            } else {
                
                loadingIndicator.startAnimating()
            }
        }
    }
 
    class func sizeForObject(_ object: TDWCollectionViewImageCellData, atIndexPath indexPath: IndexPath!, constrainedToSize constrainedSize: CGSize) -> CGSize {
        
        return CGSize(width: constrainedSize.width, height: 50)
    }
    
}
