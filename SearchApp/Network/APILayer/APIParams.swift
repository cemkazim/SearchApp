//
//  APIParams.swift
//  SearchApp
//
//  Created by Cem Kazım on 6.05.2021.
//

import Foundation

class URLCreator {
    
    public static let shared = URLCreator()
    
    private init() {}
    
    /// Description: Request the API data with parameters.
    /// - Parameters:
    ///   - term:User typed text
    ///   - path:Path type
    ///   - media: Media type (etc. movie, music, software, ebook)
    ///   - offset: Number of page
    ///   - limit: Number of items to fetch
    func createURLWithParameters(term: String, path: PathTypes, media: String, offset: Int, limit: Int) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = path.value
        components.queryItems = [
            URLQueryItem(name: "term", value: term),
            URLQueryItem(name: "limit", value: String(limit)),
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
