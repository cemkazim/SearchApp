//
//  SearchViewModel.swift
//  SearchApp
//
//  Created by Cem Kazım on 5.05.2021.
//

import Foundation

class SearchViewModel {
    
    var searchResultList: [ResultModel]?
    
    func getData(term: String, media: String, offset: String, isCompleted: @escaping () -> ()) {
        MovieDetailServiceLayer.shared.getSearchResult(term: term, media: media, offset: offset, completionHandler: { [weak self] (data: SearchResults) in
            guard let self = self, let results = data.results else { return }
            self.handleSearchResultData(results)
            isCompleted()
        })
    }
    
    func handleSearchResultData(_ results: [ResultModel]) {
        for result in results {
            let model = ResultModel(wrapperType: result.wrapperType, kind: result.kind, trackId: result.trackId,
                                    collectionName: result.collectionName, collectionPrice: result.collectionPrice,
                                    artistName: result.artistName, trackName: result.trackName, trackPrice: result.trackPrice,
                                    trackCensoredName: result.trackCensoredName, trackViewUrl: result.trackViewUrl, artworkUrl100: result.artworkUrl100,
                                    releaseDate: result.releaseDate, country: result.country, currency: result.currency,
                                    description: result.description, shortDescription: result.shortDescription, longDescription: result.longDescription)
            searchResultList?.append(model)
        }
    }
}
