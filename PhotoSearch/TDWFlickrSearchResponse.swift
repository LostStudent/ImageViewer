//
//	TDWFlickrSearchResponse.swift
//
//	Create by Christian on 8/12/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

import SwiftyJSON

class TDWFlickrSearchResponse : NSObject, NSCoding{

	var photos : TDWPhotos!
	var stat : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json == JSON.null{
			return
		}
		let photosJson = json["photos"]
		if photosJson != JSON.null{
			photos = TDWPhotos(fromJson: photosJson)
		}
		stat = json["stat"].stringValue
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if photos != nil{
			dictionary["photos"] = photos.toDictionary()
		}
		if stat != nil{
			dictionary["stat"] = stat
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         photos = aDecoder.decodeObject(forKey: "photos") as? TDWPhotos
         stat = aDecoder.decodeObject(forKey: "stat") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if photos != nil{
			aCoder.encode(photos, forKey: "photos")
		}
		if stat != nil{
			aCoder.encode(stat, forKey: "stat")
		}

	}

}
