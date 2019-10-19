//
//  Counters.swift
//  CountThings
//
//  Created by Danie Romero on 10/18/19.
//  Copyright © 2019 Dromero. All rights reserved.
//

import UIKit
import RealmSwift


class Product: Object
{
  
  @objc dynamic var remoteID = ""
  @objc dynamic var name = ""
  @objc dynamic var count = 0
 
  
  override static func primaryKey() -> String?
  {
    return "remoteID"
  }
  
}

extension Product {
  
  func save() {
    let realm = try! Realm()
    try! realm.write {
      realm.add(self)
    }
  }
  
  class func all() -> Results<Product> {
    let realm = try! Realm()
    return realm.objects(Product.self)
  }
  
  
  func delete() {
    let realm = try! Realm()
    try! realm.write {
      realm.delete(self)
    }
  }
  
  func updateCounterCount(count: Int)
  {
    let realm = try! Realm()
    try! realm.write
    {
      self.count = count
      realm.add(self)
    }
  }

  class func checkCounter(name: String) -> Bool
  {
    let realm = try! Realm()
    guard realm.objects(Product.self).filter("name = %@", name).count > 0  else {
        return false
    }
    return true
  }
 
  class func createCounter(name: String)
  {
    let counterNew = Product()
    counterNew.remoteID = UUID().uuidString
    counterNew.name = name
    counterNew.count = 1
    counterNew.save()
  }
  
  class func updateCounters(counters: NSArray)
  {
    
    let realm = try! Realm()
    let countersDB = realm.objects(Product.self)
    try! realm.write
    {
      realm.delete(countersDB)
    }
    
    for counter in counters
    {
      let counterDictionary = counter as! NSDictionary
      let id = counterDictionary["id"] as? String ?? ""
      let count = counterDictionary["count"] as? Int ?? 0
      let name = counterDictionary["title"] as? String ?? "Sin Nombre"
      
      let counterNew = Product()
      counterNew.remoteID = id
      counterNew.name = name
      counterNew.count = count
      counterNew.save()
    }
  }
  
}
