//
//  SearchResponseTests.swift
//  PhotoSearch
//
//  Created by Christian on 15/12/2016.
//  Copyright © 2016 TDW. All rights reserved.
//

import XCTest

@testable import SwiftyJSON

@testable import PhotoSearch

class SearchResponseTests: XCTestCase {
    
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
        
        let jsonString = "{\"photos\":{\"page\":1,\"pages\":\"5548\",\"perpage\":100,\"total\":\"554750\",\"photo\":[{\"id\":\"31559706691\",\"owner\":\"31840973@N02\",\"secret\":\"34d5700695\",\"server\":\"5584\",\"farm\":6,\"title\":\"Ron Weasley the red tabby\",\"ispublic\":1,\"isfriend\":0,\"isfamily\":0},{\"id\":\"31529198902\",\"owner\":\"31840973@N02\",\"secret\":\"a80279f80f\",\"server\":\"505\",\"farm\":1,\"title\":\"Colleen\",\"ispublic\":1,\"isfriend\":0,\"isfamily\":0},{\"id\":\"31559646031\",\"owner\":\"31840973@N02\",\"secret\":\"0b7f808251\",\"server\":\"542\",\"farm\":1,\"title\":\"165762-2\",\"ispublic\":1,\"isfriend\":0,\"isfamily\":0},{\"id\":\"31559646181\",\"owner\":\"31840973@N02\",\"secret\":\"bd202a7ba9\",\"server\":\"705\",\"farm\":1,\"title\":\"165762-1\",\"ispublic\":1,\"isfriend\":0,\"isfamily\":0}]}}"
        

        let response:TDWFlickrSearchResponse = TDWFlickrSearchResponse( fromJson: JSON(data: jsonString.data(using: .utf8)!) )
        
        XCTAssert((response.photos.photo.count == 4), "\(response.photos.photo.count) should == 4");
        
        XCTAssert((response.photos.page == 1), "\(response.photos.page) should == 1");
        
        XCTAssert((response.photos.pages == 5548), "\(response.photos.pages) should == 5548");
        
    }
}
