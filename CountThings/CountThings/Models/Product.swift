//
//  Product.swift
//  CountThings
//
//  Created by Danie Romero on 10/9/19.
//  Copyright © 2019 Dromero. All rights reserved.
//

import Foundation

class Product: NSObject, NSCoding {
    
    // MARK: - Types
    
    private enum CoderKeys: String {
        case nameKey
        case countKey
        case idKey
    }
    
  
    // MARK: - Properties
    
    /** These properties need @objc to make them key value compliant when filtering using NSPredicate,
        and so they are accessible and usable in Objective-C to interact with other frameworks.
    */
    @objc let title: String
    @objc var count: Int
    @objc let id: String
    
    // MARK: - Initializers
    
    init(title: String, count: Int,id:String) {
        self.title = title
        self.count = count
        self.id = id
    }
    
    // MARK: - NSCoding
  
  /// This is called for UIStateRestoration
    required init?(coder aDecoder: NSCoder) {
    guard let decodedTitle = aDecoder.decodeObject(forKey: CoderKeys.nameKey.rawValue) as? String else {
      fatalError("A title did not exist. In your app, handle this gracefully.")
    }
      title = decodedTitle
      count = aDecoder.decodeInteger(forKey: CoderKeys.countKey.rawValue)
      id = aDecoder.decodeObject(forKey: CoderKeys.idKey.rawValue) as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: CoderKeys.nameKey.rawValue)
        aCoder.encode(count, forKey: CoderKeys.countKey.rawValue)
        aCoder.encode(id, forKey: CoderKeys.idKey.rawValue)
    }
    
}
