//
//  ImageSizesResponseTests.swift
//  PhotoSearch
//
//  Created by Christian on 13/12/2016.
//  Copyright © 2016 TDW. All rights reserved.
//

import XCTest

@testable import SwiftyJSON

@testable import PhotoSearch

class ImageSizesResponseTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testResponse() {
        
        //given a data from json string does the response 
        
        let jsonString = "{\"sizes\":{\"canprint\":0,\"size\":[{\"media\":\"photo\",\"label\":\"Square\",\"source\":\"https://farm1.staticflickr.com/316/31617007405_09e9cb8111_s.jpg\",\"width\":75,\"height\":75,\"url\":\"https://www.flickr.com/photos/97313075@N08/31617007405/sizes/sq/\"},{\"media\":\"photo\",\"label\":\"Large Square\",\"source\":\"https://farm1.staticflickr.com/316/31617007405_09e9cb8111_q.jpg\",\"width\":\"150\",\"height\":\"150\",\"url\":\"https://www.flickr.com/photos/97313075@N08/31617007405/sizes/q/\"}]}}"
        
        let response = TDWFlickrImageSizesResponse(json: JSON(data: jsonString.data(using: .utf8)!))
        
        XCTAssert((response.sizes?.size?.count == 2), "\(response.sizes?.size?.count) should == 2");
        
    }
    
}
