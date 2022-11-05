//
//  Endpoint.swift
//  corpora
//
//  Created by David Ortego Lucas on 5/11/22.
//

import Foundation

enum ApiURL {
    case base
    
    var baseURL: String {
        switch self {
        case .base: return "https://rickandmortyapi.com/api/"
        }
    }
}

enum EndPoint {
    case characters
    
    var path : String {
        switch self {
        case .characters:  return "character"
        }
    }
    
    var url: String {
        switch self {
        case .characters: return "\(ApiURL.base.baseURL)\(path)"
        }
    }
}
