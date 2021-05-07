//
//  APIParams.swift
//  SearchApp
//
//  Created by Cem Kazım on 6.05.2021.
//

import Foundation

class URLCreator {
    
    static let shared = URLCreator()
    
    private init() {}
    
    func createURLWithParams(term: String, path: PathTypes, media: String, offset: Int) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = path.value
        components.queryItems = [
            URLQueryItem(name: "term", value: term),
            URLQueryItem(name: "limit", value: String(20)),
            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "media", value: media)
        ]
        return components.url
    }
}

enum PathTypes {
    
    typealias Value = String
    
    case search
    
    var value: String {
        switch self {
        case .search:
            return "/search"
        }
    }
}
