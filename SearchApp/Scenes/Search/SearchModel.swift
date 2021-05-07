//
//  SearchModel.swift
//  SearchApp
//
//  Created by Cem Kazım on 5.05.2021.
//

import Foundation

struct SearchResults: Decodable {
    
    let resultCount: Int?
    let results: [ResultModel]?
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case results
    }
}

struct ResultModel: Decodable {
    
    let wrapperType: String?
    let artistID, collectionID: Int?
    let artistName, collectionName, collectionCensoredName: String?
    let artistViewURL, collectionViewURL: String?
    let artworkUrl60, artworkUrl100: String?
    let collectionPrice: Double?
    let collectionExplicitness: String?
    let trackCount: Int?
    let country, currency: String?
    let releaseDate: String?
    let primaryGenreName: String?
    let previewURL: String?
    let shortDescription, longDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case wrapperType
        case artistID
        case collectionID
        case artistName, collectionName, collectionCensoredName
        case artistViewURL
        case collectionViewURL
        case artworkUrl60, artworkUrl100, collectionPrice, collectionExplicitness, trackCount, country, currency, releaseDate, primaryGenreName
        case previewURL
        case shortDescription, longDescription
    }
}

class SearchItemModel {
    
    var name: String?
    var imageURL: URL?
    var releaseDate: String?
    var price: String?
    var genre: String?
    var description: String?
    
    init(name: String?, imageURL: URL?, releaseDate: String?, price: String?, genre: String?, description: String?) {
        self.name = name
        self.imageURL = imageURL
        self.releaseDate = releaseDate
        self.price = price
        self.genre = genre
        self.description = description
    }
}
