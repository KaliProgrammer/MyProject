//
//  BookModel.swift
//  TestovoeBooks
//
//  Created by MacBook Air on 18.04.2023.
//

import Foundation

struct Books: Codable{
    let object: [BookObject]
}
struct Doc: Codable {
    let titleSuggest: String?
    let subtitle: String?
    let authorName: [String]?
    let firstPublishYear: Int?
    let coverI: Int?
    
    enum CodingKeys: String, CodingKey {
        case titleSuggest = "title_suggest"
        case subtitle
        case authorName = "author_name"
        case firstPublishYear = "first_publish_year"
        case coverI = "cover_i"
    }
}
struct BookObject: Codable{
    let start: Int?
    let numFound: Int?
    let docs: [Doc]
    
    enum CodingKeys: String, CodingKey {
        case start
        case numFound = "num_found"
        case docs
    }
}
