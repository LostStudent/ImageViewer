//
//  TDWCellSizeManager.swift
//  PhotoSearch
//
//  Created by Christian on 10/12/2016.
//  Copyright © 2016 TDW. All rights reserved.
//

import UIKit

/*
For a future update I will make cell sizes random but with a particular pattern, tests not passing yet
 */

class TDWCellSizeManager: NSObject {

    let sizeGroups:[[CGSize]]!
    
    init(width:CGFloat) {
        
        let sizeGroup1 = [CGSize(width:width,height: 200)]
        
        let sizeGroup2 = [CGSize(width:width/2,height: 200),CGSize(width:width/2,height: 200)]
        
        let sizeGroup3 = [CGSize(width:width/3,height: 200),CGSize(width:width/3 * 2,height: 200)]
        
        let sizeGroup4 = [CGSize(width:width/3 * 2,height: 200),CGSize(width:width/3,height: 200)]
        
        self.sizeGroups = [sizeGroup1,sizeGroup2,sizeGroup3,sizeGroup4]
        
    }
    
    // I want to make the results more intresting by randomizing the cell size, so will calculate the appripate one here and store in data
    
    class func getNextSize(_ width:CGFloat,sizeGroups: [[CGSize]], currentSizeGroupIdx:Int, currentSizeIdx:Int) -> (size:CGSize,sizeGroupIdx:Int,sizeIdx:Int) {
        
        
        let sizeGroup = sizeGroups[currentSizeGroupIdx]
        
        let currentSize = sizeGroup[currentSizeIdx]
        
        var newSizeGroupIdx:Int = 0
        
        var newSizeIdx:Int = 0
        
        if(currentSizeIdx + 1 < sizeGroup.count) {
            
            newSizeIdx = currentSizeIdx + 1
            
            if(currentSizeGroupIdx + 1 < sizeGroups.count) {
                
                newSizeGroupIdx = currentSizeGroupIdx
                
            } else {
                
                newSizeGroupIdx += 1
            }
        }
        
        return (size:currentSize, sizeGroupIdx:newSizeGroupIdx,sizeIdx:newSizeIdx)
    }
    
}
