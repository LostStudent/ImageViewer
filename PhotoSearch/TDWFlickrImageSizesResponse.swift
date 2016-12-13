//
//  TDWFlickrImageSizesResponse.swift
//
//  Created by Christian on 13/12/2016
//  Copyright (c) TDW. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class TDWFlickrImageSizesResponse: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let stat = "stat"
    static let sizes = "sizes"
  }

  // MARK: Properties
  public var stat: String?
  public var sizes: TDWSizes?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    stat = json[SerializationKeys.stat].string
    sizes = TDWSizes(json: json[SerializationKeys.sizes])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = stat { dictionary[SerializationKeys.stat] = value }
    if let value = sizes { dictionary[SerializationKeys.sizes] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.stat = aDecoder.decodeObject(forKey: SerializationKeys.stat) as? String
    self.sizes = aDecoder.decodeObject(forKey: SerializationKeys.sizes) as? TDWSizes
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(stat, forKey: SerializationKeys.stat)
    aCoder.encode(sizes, forKey: SerializationKeys.sizes)
  }

}
