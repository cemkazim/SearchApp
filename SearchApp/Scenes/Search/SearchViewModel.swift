//
//  SearchViewModel.swift
//  SearchApp
//
//  Created by Cem Kazım on 5.05.2021.
//

import Foundation

class SearchViewModel {
    
    var searchResultList = [SearchItemModel]()
    var searchResultCallback: (() -> ())?
    var pageCount: Int = 1
    
    func getSearchResultData(term: String, media: String) {
        SearchServiceLayer.shared.getSearchResult(term: term, media: media, offset: pageCount, completionHandler: { [weak self] (data: SearchResults) in
            guard let self = self, let results = data.results else { return }
            self.handleSearchResultData(results)
            self.searchResultCallback?()
        })
    }
    
    func handleSearchResultData(_ results: [ResultModel]) {
        for result in results {
            let collectionName = result.collectionName
            let url = URL(string: result.artworkUrl100 ?? "")
            let date = formatDate(with: result.releaseDate ?? "")
            let price = String(format: "%.2f", result.collectionPrice ?? 0) + "$"
            let genre = result.primaryGenreName
            let description = result.longDescription
            let model = SearchItemModel(name: collectionName, imageURL: url, releaseDate: date, price: price, genre: genre, description: description)
            searchResultList.append(model)
        }
    }
    
    func listenSearchResultCallback(isCompleted: @escaping () -> ()) {
        searchResultCallback = isCompleted
    }
    
    func formatDate(with dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: dateString) else { return "" }
        dateFormatter.dateFormat = "MMM dd,yyyy"
        return dateFormatter.string(from: date)
    }
}
