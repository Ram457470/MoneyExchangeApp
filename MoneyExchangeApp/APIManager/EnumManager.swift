//
//  EnumManager.swift
//  MoneyExchangeApp
//
//  Created by Ram Naidu on 12/11/24.
//

import Foundation

enum RequestHeaders {
    static let contentType = "Content-Type"
    static let applicationJSON = "application/json"
    static let formData = "application/x-www-form-urlencoded"
}

enum Event {
    case loading
    case stopLoading
    case dataLoaded
    case error(Error?)
}

enum RequestErrors: Error {
    case decode
    case invalidURL
    case invalidData
    case invalidResponse
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}

enum RequestMethod: String {
    case get = "GET"
}

enum APIEndpoint {
    case getAllCountryList
}

extension APIEndpoint: Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "restcountries.com"
    }
    
    var path: String {
        switch self {
        case .getAllCountryList:
            return "/v3.1/independent"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getAllCountryList:
            return .get
            
        }
    }
    var parameters: [URLQueryItem]? {
        switch self {
        case .getAllCountryList:
            return [URLQueryItem(name: "fields", value: "name,languages,capital,flags,currencies,cca2,cioc")]
        }
    }
    var header: [String: String]? {
        switch self {
        default:
            return [
                "Content-Type": "application/json"
            ]
        }
    }
    var body: Encodable?{
        switch self {
        case .getAllCountryList:
            return nil
        }
    }
}
