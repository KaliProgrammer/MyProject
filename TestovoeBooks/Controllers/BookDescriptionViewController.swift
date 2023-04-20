//
//  BookDescriptionViewController.swift
//  TestovoeBooks
//
//  Created by MacBook Air on 20.04.2023.
//

import Foundation
import UIKit
import SnapKit

class BookDescriptionViewController: UIViewController {

    var contentView = BookView()
    var bookViewModel: BookViewModel
    
    var selectedIndex: Int = 0
    
    init(_ bookViewModel: BookViewModel) {
        self.bookViewModel = bookViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupUI()
        contentView.publishedYearLabel.text = bookViewModel.yearLabel.description
        contentView.authorNameLabel.text = bookViewModel.authorLabel
        contentView.bookNameLabel.text = bookViewModel.titleLabel.description
        
        if let id = bookViewModel.book.coverI {
            bookViewModel.loadImage(image: contentView.bookImage, coverID: id)
        } else {
            contentView.bookImage.image = UIImage(named: "ImageNotFound")
        }
    }
    
    func setupUI() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(800)
        }
    }
}
