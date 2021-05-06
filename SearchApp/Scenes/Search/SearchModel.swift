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
    let kind: String?
    let trackId: Int?
    let collectionName: String?
    let collectionPrice: Double?
    let artistName: String?
    let trackName: String?
    let trackPrice: Double?
    let trackCensoredName: String?
    let trackViewUrl: String?
    let artworkUrl100: String?
    let releaseDate: String?
    let country: String?
    let currency: String?
    let description: String?
    let shortDescription: String?
    let longDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case wrapperType
        case kind
        case trackId
        case collectionName
        case collectionPrice
        case artistName
        case trackName
        case trackPrice
        case trackCensoredName
        case trackViewUrl
        case artworkUrl100
        case releaseDate
        case country
        case currency
        case description
        case shortDescription
        case longDescription
    }
}

class SearchItemModel {
    
    var name: String?
    var imageURL: URL?
    var releaseDate: String?
    var price: String?
    
    init(name: String?, imageURL: URL?, releaseDate: String?, price: String?) {
        self.name = name
        self.imageURL = imageURL
        self.releaseDate = releaseDate
        self.price = price
    }
}
