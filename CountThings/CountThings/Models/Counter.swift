//
//  Counters.swift
//  CountThings
//
//  Created by Danie Romero on 10/18/19.
//  Copyright © 2019 Dromero. All rights reserved.
//

import UIKit
import RealmSwift


class Counter: Object
{
  
  @objc dynamic var remoteID = ""
  @objc dynamic var name = ""
  @objc dynamic var count = 0
 
  
  override static func primaryKey() -> String?
  {
    return "remoteID"
  }
  
}

extension Counter {
  
  func save() {
    let realm = try! Realm()
    try! realm.write {
      realm.add(self, update: true)
    }
  }
  
  class func all() -> Results<Counter> {
    let realm = try! Realm()
    return realm.objects(Counter.self)
  }
  
  
  func delete() {
    let realm = try! Realm()
    try! realm.write {
      realm.delete(self)
    }
  }
  
  class func updateCounters(counters: NSArray)
  {
    
    let realm = try! Realm()
    let counters = realm.objects(Counter.self)
    try! realm.write
    {
      realm.delete(counters)
    }
    
    for counter in counters
    {
      let counterDictionary = counter as! NSDictionary
      let id = counterDictionary["id"] as? String ?? ""
      let count = counterDictionary["count"] as? Int ?? 0
      let name = counterDictionary["title"] as? String ?? "Sin Nombre"
      
      let counterNew = Counter()
      counterNew.remoteID = id
      counterNew.name = name
      counterNew.count = count
      counterNew.save()
    }
  }
  
}
