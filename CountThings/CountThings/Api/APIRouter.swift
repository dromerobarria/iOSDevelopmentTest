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
  
  /// Get Counters
  case allCounters
  /// Increase Counter
  case increaseCounter(parameters: [String: AnyObject])
  /// Descrease Counter
  case decreaseCounter(parameters: [String: AnyObject])
  /// Delete Counter
  case deleteCounter(parameters: [String: AnyObject])
  /// Create Counter
  case createCounter(parameters: [String: AnyObject])
  
  // MARK: - HTTPMethod
  private var method: HTTPMethod
  {
    switch self
    {
    case .allCounters:
      return .get
    case .increaseCounter:
      return .post
    case .decreaseCounter:
      return .post
    case .deleteCounter:
      return .delete
    case .createCounter:
      return .post
    }
  }
  
  // MARK: - Path
  private var path: String
  {
    switch self
    {
    case .allCounters:
      return "counters"
    case .increaseCounter(_):
      return "counter/inc"
    case .decreaseCounter(_):
      return "counter/dec"
    case .deleteCounter(_):
      return "counter"
    case .createCounter(_):
      return "counter"
    }
  }
  
  // MARK: - Parameters
  private var parameters: Parameters?
  {
    switch self
    {
    case .allCounters:
      return nil
    case .increaseCounter(let parameters):
      return parameters
    case .decreaseCounter(let parameters):
      return parameters
    case .deleteCounter(let parameters):
      return parameters
    case .createCounter(let parameters):
      return parameters
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
    
    /// HTTP Method
    urlRequest.httpMethod = method.rawValue
    
    /// Common Headers
    urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
    urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
    
    print("UrlRequest : \(urlRequest)")
    
    /// Parameters
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

