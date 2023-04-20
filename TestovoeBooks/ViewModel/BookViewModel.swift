//
//  BookViewModel.swift
//  TestovoeBooks
//
//  Created by MacBook Air on 20.04.2023.
//

import Foundation
import UIKit

class BookViewModel  {
    
    let book: Doc
    init(book: Doc) {
        self.book = book
    }
    
    func loadImage(image: UIImageView, coverID: Int) {
        if let bookUrl = URL(string: "https://covers.openlibrary.org/b/id/" + "\(coverID)" + "-M.jpg") {
            if coverID > 0 {
                image.sd_setImage(with: bookUrl, placeholderImage: UIImage(named: "ImageNotFound"))
            }
        }
    }
    
    //MARK: - Computed Property
   
    var titleLabel: String {
        if let bookTitle = book.titleSuggest {
            return "Title: \(bookTitle)"
        } else {
            return "No title"
        }
    }
    
    var authorLabel: String {
        if let authorTitle = book.authorName {
            return "Author: \(authorTitle[0])"
        } else {
            return "No author"
        }
    }
    
    var yearLabel: String {
        if let year = book.firstPublishYear {
            return "Published in: \(year)"
        } else {
            return "Unavailable"
        }
    }
}
