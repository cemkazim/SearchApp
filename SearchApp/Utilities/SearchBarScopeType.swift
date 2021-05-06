//
//  SearchBarScopeType.swift
//  SearchApp
//
//  Created by Cem Kazım on 5.05.2021.
//

import Foundation

enum SearchBarScopeType: String {
    case movie
    case music
    case software
    case ebook
    
    var scopeTitle: String {
        switch self {
        case .movie:
            return "Movies"
        case .music:
            return "Music"
        case .software:
            return "Apps"
        case .ebook:
            return "Books"
        }
    }
}
