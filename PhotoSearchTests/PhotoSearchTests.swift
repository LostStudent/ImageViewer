//
//  PhotoSearchTests.swift
//  PhotoSearchTests
//
//  Created by Christian on 09/12/2016.
//  Copyright © 2016 TDW. All rights reserved.
//

import XCTest

import UIKit

@testable import PhotoSearch

class PhotoSearchTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGOne() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        var currentSizeGroupIdx = 0
        
        var currentSizeIdx = 0
        
        let width = CGFloat(200)
        
        let sizeGroup1 = [CGSize(width:width,height: 200)]
        
        let sizeGroup2 = [CGSize(width:width/2,height: 200),CGSize(width:width/2,height: 200)]
        
        let sizeGroup3 = [CGSize(width:width/3,height: 200),CGSize(width:width/3 * 2,height: 200)]
        
        let sizeGroup4 = [CGSize(width:width/3 * 2,height: 200),CGSize(width:width/3,height: 200)]
        
        let sizeGroups = [sizeGroup1,sizeGroup2,sizeGroup3,sizeGroup4]
        
        let sizeInfo = TDWCellSizeManager.getNextSize(width,
                                                                          sizeGroups: sizeGroups,
                                                                          currentSizeGroupIdx: currentSizeGroupIdx,
                                                                          currentSizeIdx: currentSizeIdx)
    
        currentSizeGroupIdx = sizeInfo.sizeGroupIdx
        
        currentSizeIdx = sizeInfo.sizeIdx
        
        XCTAssert((currentSizeGroupIdx == 1), "\(currentSizeGroupIdx) should be 1")
        
        XCTAssert((currentSizeIdx == 0), "\(currentSizeIdx) should be 0")
    }
    
    func testG2() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        var currentSizeGroupIdx = 1
        
        var currentSizeIdx = 0
        
        let width = CGFloat(200)
        
        let sizeGroup1 = [CGSize(width:width,height: 200)]
        
        let sizeGroup2 = [CGSize(width:width/2,height: 200),CGSize(width:width/2,height: 200)]
        
        let sizeGroup3 = [CGSize(width:width/3,height: 200),CGSize(width:width/3 * 2,height: 200)]
        
        let sizeGroup4 = [CGSize(width:width/3 * 2,height: 200),CGSize(width:width/3,height: 200)]
        
        let sizeGroups = [sizeGroup1,sizeGroup2,sizeGroup3,sizeGroup4]
        
        let sizeInfo = TDWCellSizeManager.getNextSize(width,
                                                                          sizeGroups: sizeGroups,
                                                                          currentSizeGroupIdx: currentSizeGroupIdx,
                                                                          currentSizeIdx: currentSizeIdx)
        
        currentSizeGroupIdx = sizeInfo.sizeGroupIdx
        
        currentSizeIdx = sizeInfo.sizeIdx
        
        XCTAssert((currentSizeGroupIdx == 1), "\(currentSizeGroupIdx) should be 1")
        
        XCTAssert((currentSizeIdx == 1), "\(currentSizeIdx) should be 1")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
