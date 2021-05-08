//
//  SearchServiceLayer.swift
//  SearchApp
//
//  Created by Cem Kazım on 5.05.2021.
//

import Foundation

class SearchServiceLayer {
    
    static let shared = SearchServiceLayer()
    
    private init() {}
    
    /// Description: Request the API data with parameters.
    /// - Parameters:
    ///   - term:User typed text
    ///   - media: Media type (etc. movie, music, software, ebook)
    ///   - offset: Number of page
    ///   - limit: Number of items to fetch
    ///   - completionHandler: Pass the data with completion
    func getSearchResult(term: String, media: String, offset: Int, limit: Int, completionHandler: @escaping (SearchResults) -> Void) {
        let searchTerm = term.replacingOccurrences(of: " ", with: "+")
        let url = URLCreator.shared.createURLWithParameters(term: searchTerm, path: .search, media: media, offset: offset, limit: limit)
        guard let urlString = url?.absoluteString else { return }
        BaseNetworkLayer.shared.request(requestUrl: urlString, requestMethod: .get, onCompleted: { (data: SearchResults) in
            completionHandler(data)
        })
    }
}
