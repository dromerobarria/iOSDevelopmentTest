//
//  Constants.swift
//  CountThings
//
//  Created by Danie Romero on 10/8/19.
//  Copyright © 2019 Dromero. All rights reserved.
//

import Foundation
import UIKit


struct Constants
{
  struct Sizes {
    static let small:Float = 13.0
    static let medium:Float = 18.0
    static let large:Float = 22.0
  }
  
  struct Messages
  {
    struct Alert
    {
       static let OKLabel = NSLocalizedString("OK", comment: "")
    }
    
    struct General
    {
       static let titleText = NSLocalizedString("CountThings", comment: "")
       static let countText = NSLocalizedString("Total", comment: "")
       static let nameText = NSLocalizedString("Nombre", comment: "")
       static let navText = NSLocalizedString("iOS Development Test", comment: "")
       static let createAlertText = NSLocalizedString("Favor ingrese el nombre del elemento", comment: "")
       static let cancelText = NSLocalizedString("Cancelar", comment: "")
       static let createText = NSLocalizedString("Crear", comment: "")
    }
    
   
  }
}


struct Api
{
  struct Server
  {
    //True Development // False Production
    static let debugURL = true

    static let baseURL = "http://localhost:3000" // Production
    static let testUrl = "http://localhost:3000" // Developer
    static let version = "/api/v1/"
  }
}

struct Config
{
  static var versionApp = "v1.0.0"
  static var versionDevApp = "v1.0.0 Dev."
}

enum HTTPHeaderField: String
{
  case authentication = "Authorization"
  case contentType = "Content-Type"
  case acceptType = "Accept"
  case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String
{
  case json = "application/json"
}
