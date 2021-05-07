//
//  SearchModel.swift
//  SearchApp
//
//  Created by Cem Kazım on 5.05.2021.
//

import Foundation

public struct SearchResults: Decodable {
    
    public let resultCount: Int?
    public let results: [ResultModel]?
}

public struct ResultModel: Decodable {
    
    public let wrapperType: String?
    public let artistID, collectionID: Int?
    public let artistName, collectionName, collectionCensoredName: String?
    public let artistViewURL, collectionViewURL: String?
    public let artworkUrl60, artworkUrl100: String?
    public let collectionPrice: Double?
    public let collectionExplicitness: String?
    public let trackCount: Int?
    public let country, currency: String?
    public let releaseDate: String?
    public let primaryGenreName: String?
    public let previewURL: String?
    public let description, shortDescription, longDescription: String?
}

public class SearchItemModel {
    
    public var name: String?
    public var imageURL: URL?
    public var releaseDate: String?
    public var price: String?
    public var genre: String?
    public var description: String?
    
    public init(name: String?, imageURL: URL?, releaseDate: String?, price: String?, genre: String?, description: String?) {
        self.name = name
        self.imageURL = imageURL
        self.releaseDate = releaseDate
        self.price = price
        self.genre = genre
        self.description = description
    }
}
