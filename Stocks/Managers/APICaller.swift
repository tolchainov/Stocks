//
//  APICaller.swift
//  Stocks
//
//  Created by Ivan Tolchainov on 17.01.2022.
//

import Foundation
import Metal

final class APICaller {
    static let shared = APICaller()
    
    private struct Constant {
        static let apiKey = "c7k5heaad3i9q0uqhdd0"
        static let sandboxApiKey = "sandbox_c7k5heaad3i9q0uqhddg"
        static let baseUrl = "https://finnhub.io/api/v1/"
    }
    
    private init() {}
    
    public func search(
        query: String,
        completion: @escaping (Result<SearchResponse, Error>) -> Void
    ) {
        
        guard let safeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            else {
            return
        }
                
        request(url: url(for: .search, queryParams: ["q":query]), expecting: SearchResponse.self, completion: completion)
    

    }
    
    private enum Endpoint: String {
        case search
        
    }
    
    private enum APIError: Error {
        case noDataReturned
        case invalidUrl
    }
    
    private func url(
        for endpoint: Endpoint,
        queryParams: [String: String] = [:]
    ) -> URL? {
        var urlString = Constant.baseUrl + endpoint.rawValue
        
        var queryItems = [URLQueryItem]()
        
        for (name, value) in queryParams {
            queryItems.append(.init(name: name, value: value))
        }
        queryItems.append(.init(name: "token", value: Constant.apiKey))
        
        urlString += "?" + queryItems.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&")
        
        print("\n\(urlString)\n")
        
        return URL(string: urlString)
    }
    
    private func request<T: Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void) {
            guard let url = url else {
                completion(.failure(APIError.invalidUrl))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(APIError.noDataReturned))
                    }
                    return
                }
                do {
                    let result = try JSONDecoder().decode(expecting, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
}
