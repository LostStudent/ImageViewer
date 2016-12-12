//
//	TDWPhoto.swift
//
//	Create by Christian on 8/12/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

import SwiftyJSON

class TDWPhoto : NSObject, NSCoding{

	var farm : Int!
	var id : String!
	var isfamily : Int!
	var isfriend : Int!
	var ispublic : Int!
	var owner : String!
	var secret : String!
	var server : String!
	var title : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json == JSON.null{
			return
		}
		farm = json["farm"].intValue
		id = json["id"].stringValue
		isfamily = json["isfamily"].intValue
		isfriend = json["isfriend"].intValue
		ispublic = json["ispublic"].intValue
		owner = json["owner"].stringValue
		secret = json["secret"].stringValue
		server = json["server"].stringValue
		title = json["title"].stringValue
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if farm != nil{
			dictionary["farm"] = farm
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isfamily != nil{
			dictionary["isfamily"] = isfamily
		}
		if isfriend != nil{
			dictionary["isfriend"] = isfriend
		}
		if ispublic != nil{
			dictionary["ispublic"] = ispublic
		}
		if owner != nil{
			dictionary["owner"] = owner
		}
		if secret != nil{
			dictionary["secret"] = secret
		}
		if server != nil{
			dictionary["server"] = server
		}
		if title != nil{
			dictionary["title"] = title
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         farm = aDecoder.decodeObject(forKey: "farm") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? String
         isfamily = aDecoder.decodeObject(forKey: "isfamily") as? Int
         isfriend = aDecoder.decodeObject(forKey: "isfriend") as? Int
         ispublic = aDecoder.decodeObject(forKey: "ispublic") as? Int
         owner = aDecoder.decodeObject(forKey: "owner") as? String
         secret = aDecoder.decodeObject(forKey: "secret") as? String
         server = aDecoder.decodeObject(forKey: "server") as? String
         title = aDecoder.decodeObject(forKey: "title") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if farm != nil{
			aCoder.encode(farm, forKey: "farm")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isfamily != nil{
			aCoder.encode(isfamily, forKey: "isfamily")
		}
		if isfriend != nil{
			aCoder.encode(isfriend, forKey: "isfriend")
		}
		if ispublic != nil{
			aCoder.encode(ispublic, forKey: "ispublic")
		}
		if owner != nil{
			aCoder.encode(owner, forKey: "owner")
		}
		if secret != nil{
			aCoder.encode(secret, forKey: "secret")
		}
		if server != nil{
			aCoder.encode(server, forKey: "server")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}

	}

}
