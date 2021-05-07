//
//  SearchServiceLayer.swift
//  SearchApp
//
//  Created by Cem Kazım on 5.05.2021.
//

import Foundation
import RxSwift

public class SearchServiceLayer {
    
    public static let shared = SearchServiceLayer()
    private var disposeBag = DisposeBag()
    
    private init() {}
    
    public func getSearchResult(term: String, media: String, offset: Int, completionHandler: @escaping (SearchResults) -> Void) {
        let searchTerm = term.replacingOccurrences(of: " ", with: "+")
        let url = URLCreator.shared.createURLWithParams(term: searchTerm, path: .search, media: media, offset: offset)
        guard let urlString = url?.absoluteString else { return }
        BaseNetworkLayer.shared.request(requestUrl: urlString, requestMethod: .get).subscribe(onNext: { (data: SearchResults) in
            completionHandler(data)
        }, onError: { (error: Error) in
            print(error)
        }).disposed(by: disposeBag)
    }
}
