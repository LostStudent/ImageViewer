//
//	TDWPhotos.swift
//
//	Create by Christian on 8/12/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

import SwiftyJSON

class TDWPhotos : NSObject, NSCoding{

	var page : Int!
	var pages : Int!
	var perpage : Int!
	var photo : [TDWPhoto]!
	var total : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json == JSON.null{
			return
		}
		page = json["page"].intValue
		pages = json["pages"].intValue
		perpage = json["perpage"].intValue
		photo = [TDWPhoto]()
		let photoArray = json["photo"].arrayValue
		for photoJson in photoArray{
			let value = TDWPhoto(fromJson: photoJson)
			photo.append(value)
		}
		total = json["total"].stringValue
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if page != nil{
			dictionary["page"] = page
		}
		if pages != nil{
			dictionary["pages"] = pages
		}
		if perpage != nil{
			dictionary["perpage"] = perpage
		}
		if photo != nil{
			var dictionaryElements = [NSDictionary]()
			for photoElement in photo {
				dictionaryElements.append(photoElement.toDictionary())
			}
			dictionary["photo"] = dictionaryElements
		}
		if total != nil{
			dictionary["total"] = total
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         page = aDecoder.decodeObject(forKey: "page") as? Int
         pages = aDecoder.decodeObject(forKey: "pages") as? Int
         perpage = aDecoder.decodeObject(forKey: "perpage") as? Int
         photo = aDecoder.decodeObject(forKey: "photo") as? [TDWPhoto]
         total = aDecoder.decodeObject(forKey: "total") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if page != nil{
			aCoder.encode(page, forKey: "page")
		}
		if pages != nil{
			aCoder.encode(pages, forKey: "pages")
		}
		if perpage != nil{
			aCoder.encode(perpage, forKey: "perpage")
		}
		if photo != nil{
			aCoder.encode(photo, forKey: "photo")
		}
		if total != nil{
			aCoder.encode(total, forKey: "total")
		}

	}

}
