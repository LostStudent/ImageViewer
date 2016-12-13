//
//  TDWSize.swift
//
//  Created by Christian on 13/12/2016
//  Copyright (c) TDW. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class TDWSize: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let label = "label"
    static let height = "height"
    static let media = "media"
    static let source = "source"
    static let url = "url"
    static let width = "width"
  }

  // MARK: Properties
  public var label: String?
  public var height: String?
  public var media: String?
  public var source: String?
  public var url: String?
  public var width: String?

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
    label = json[SerializationKeys.label].string
    height = json[SerializationKeys.height].string
    media = json[SerializationKeys.media].string
    source = json[SerializationKeys.source].string
    url = json[SerializationKeys.url].string
    width = json[SerializationKeys.width].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = label { dictionary[SerializationKeys.label] = value }
    if let value = height { dictionary[SerializationKeys.height] = value }
    if let value = media { dictionary[SerializationKeys.media] = value }
    if let value = source { dictionary[SerializationKeys.source] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    if let value = width { dictionary[SerializationKeys.width] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.label = aDecoder.decodeObject(forKey: SerializationKeys.label) as? String
    self.height = aDecoder.decodeObject(forKey: SerializationKeys.height) as? String
    self.media = aDecoder.decodeObject(forKey: SerializationKeys.media) as? String
    self.source = aDecoder.decodeObject(forKey: SerializationKeys.source) as? String
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
    self.width = aDecoder.decodeObject(forKey: SerializationKeys.width) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(label, forKey: SerializationKeys.label)
    aCoder.encode(height, forKey: SerializationKeys.height)
    aCoder.encode(media, forKey: SerializationKeys.media)
    aCoder.encode(source, forKey: SerializationKeys.source)
    aCoder.encode(url, forKey: SerializationKeys.url)
    aCoder.encode(width, forKey: SerializationKeys.width)
  }

}
