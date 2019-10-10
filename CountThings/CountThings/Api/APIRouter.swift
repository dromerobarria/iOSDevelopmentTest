//
//  APIRouter.swift
//  CountThings
//
//  Created by Danie Romero on 10/10/19.
//  Copyright © 2019 Dromero. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible
{
  
  //App
  case allCounters
  
  
  // MARK: - HTTPMethod
  private var method: HTTPMethod
  {
    switch self
    {
    case .allCounters:
      return .get
    }
  }
  
  // MARK: - Path
  private var path: String
  {
    switch self
    {
    case .allCounters:
      return "counters"
    }
  }
  
  // MARK: - Parameters
  private var parameters: Parameters?
  {
    switch self
    {
    case .allCounters:
      return nil
    }
  }
  
  // MARK: - URLRequestConvertible
  func asURLRequest() throws -> URLRequest
  {
    
    let urlString = Api.Server.debugURL ? Api.Server.testUrl : Api.Server.baseURL
    
    var urlRequest : URLRequest
    
    var url = URL(string: "")
    url = URL(string: urlString + Api.Server.version)!
    urlRequest = URLRequest(url: url!.appendingPathComponent(path))
    
    // HTTP Method
    urlRequest.httpMethod = method.rawValue
    
    // Common Headers
    urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
    urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
    
    print("UrlRequest : \(urlRequest)")
    
    // Parameters
    if let parameters = parameters
    {
      do
      {
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
      } catch
      {
        throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
      }
    }
    return urlRequest
  }
}

