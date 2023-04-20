//
//  NetworkService.swift
//  TestovoeBooks
//
//  Created by MacBook Air on 18.04.2023.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case custom(String)
    case emptyData
    case wrongJson(String)
    case wrongURL
    case wrongParameters

    var description: String {
        switch self {
        case .custom(let text):
            return text
        case .emptyData:
            return "empty data"
        case .wrongJson(let json):
            return "wrong json - \(json)"
        case .wrongURL:
            return "wrong URL"
        case .wrongParameters:
            return "wrong params"
        }
    }
}

actor NetworkService {
    
    func fetchBooks(by keyword: String) async throws -> BookObject {
        guard !keyword.isEmpty else {
            return BookObject(start: nil, numFound: 0, docs: [])
        }
        let urlString = "https://openlibrary.org/search.json?q=" + "\(keyword)"
        guard let url = URL(string: urlString.replacingOccurrences(of: " ", with: "+")) else {
            throw NetworkError.wrongURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkError.custom("Wrong response")
        }
        let result = try JSONDecoder().decode(BookObject.self, from: data)
        return result
    }
}
