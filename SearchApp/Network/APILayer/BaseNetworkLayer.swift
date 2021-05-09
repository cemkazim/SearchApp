//
//  BaseNetworkLayer.swift
//  SearchApp
//
//  Created by Cem Kazım on 5.05.2021.
//

import Alamofire

class BaseNetworkLayer {
    
    static let shared = BaseNetworkLayer()
    
    private init() {}
    
    /// Description: Request the API data with parameters (T is a decodable model).
    /// - Parameters:
    ///   - requestUrl: Formatted url for API data
    ///   - requestMethod: Any HTTPMethod
    ///   - requestParameters: Request body (optional)
    ///   - onCompleted: Pass the data with completion
    func request<T: Decodable>(requestUrl: String, requestMethod: HTTPMethod, requestParameters: Parameters? = nil, onCompleted: @escaping (T) -> ()) {
        AF.request(requestUrl, method: requestMethod, parameters: requestParameters, encoding: URLEncoding.default).response { (response) in
            guard let remoteData = response.data else { return }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: remoteData)
                onCompleted(decodedData)
            } catch let error {
                print(error)
            }
        }
    }
}
