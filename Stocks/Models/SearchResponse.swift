//
//  SearchResponse.swift
//  Stocks
//
//  Created by Ivan Tolchainov on 19.01.2022.
//

import Foundation

struct SearchResponse: Codable {
    let count: Int
    let result: [SearchResult]
}

struct SearchResult: Codable {
    let description: String
    let displaySymbol: String
    let symbol: String
    let type: String
}
