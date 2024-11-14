//
//  APIManagerProtocal.swift
//  MoneyExchangeApp
//
//  Created by Ram Naidu on 12/11/24.
//

import UIKit

protocol APIManagerProtocol {
    func getDecodaleData<D: Decodable>(from endpoint: Endpoint,with responseModel: D.Type,completion: @escaping Handler<D>)
}

typealias Handler<T> = (Result<T, RequestErrors>) -> Void

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: Encodable? { get }
    var parameters: [URLQueryItem]? { get }
}

final class APIManager:APIManagerProtocol {
    
    func getDecodaleData<D: Decodable>(
        from endpoint: Endpoint,
        with responseModel: D.Type,
        completion: @escaping Handler<D>
    ){
        do {
            let request = try createRequest(from: endpoint)
            debugPrint("final url request: \(request)")
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data, error == nil else {
                    completion(.failure(.invalidData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      200 ... 299 ~= response.statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let resultData = try JSONDecoder().decode(responseModel.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(resultData))
                    }
                }catch {
                    completion(.failure(.decode))
                }
                
            }.resume()
        } catch let error {
            debugPrint(error)
        }
    }
}

extension APIManager {
    func createRequest(from endpoint: Endpoint) throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        if let parameters = endpoint.parameters {
            debugPrint("sending parameters: \(parameters)")
            urlComponents.queryItems = parameters
        }
        guard let url = urlComponents.url else {
            throw RequestErrors.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            debugPrint("sending body params : \(body)")
            request.httpBody = try? JSONEncoder().encode(body)
        }
        
        return request
    }
}
