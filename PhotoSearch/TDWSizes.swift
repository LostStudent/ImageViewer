//
//  TDWSizes.swift
//
//  Created by Christian on 13/12/2016
//  Copyright (c) TDW. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class TDWSizes: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let canprint = "canprint"
    static let size = "size"
    static let candownload = "candownload"
    static let canblog = "canblog"
  }

  // MARK: Properties
  public var canprint: Int?
  public var size: [TDWSize]?
  public var candownload: Int?
  public var canblog: Int?

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
    canprint = json[SerializationKeys.canprint].int
    if let items = json[SerializationKeys.size].array { size = items.map { TDWSize(json: $0) } }
    candownload = json[SerializationKeys.candownload].int
    canblog = json[SerializationKeys.canblog].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = canprint { dictionary[SerializationKeys.canprint] = value }
    if let value = size { dictionary[SerializationKeys.size] = value.map { $0.dictionaryRepresentation() } }
    if let value = candownload { dictionary[SerializationKeys.candownload] = value }
    if let value = canblog { dictionary[SerializationKeys.canblog] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.canprint = aDecoder.decodeObject(forKey: SerializationKeys.canprint) as? Int
    self.size = aDecoder.decodeObject(forKey: SerializationKeys.size) as? [TDWSize]
    self.candownload = aDecoder.decodeObject(forKey: SerializationKeys.candownload) as? Int
    self.canblog = aDecoder.decodeObject(forKey: SerializationKeys.canblog) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(canprint, forKey: SerializationKeys.canprint)
    aCoder.encode(size, forKey: SerializationKeys.size)
    aCoder.encode(candownload, forKey: SerializationKeys.candownload)
    aCoder.encode(canblog, forKey: SerializationKeys.canblog)
  }

}
