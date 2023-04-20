//
//  Cell.swift
//  TestovoeBooks
//
//  Created by MacBook Air on 18.04.2023.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class Cell: UITableViewCell {
    
    lazy var bookImageView: UIImageView = {
        let bookImage = UIImageView()
        bookImage.layer.cornerRadius = 22
        bookImage.layer.masksToBounds = true
        return bookImage
    }()
    
    lazy var bookTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            bookTitleLabel,
            authorLabel,
            yearLabel
        ])
        stack.axis = .vertical
        stack.spacing = 3
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews([bookImageView,
                     vStack])
        setupElements()
        contentView.backgroundColor = .white
    }
    
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookImageView.image = UIImage(named: "ImageNotFound")
        bookTitleLabel.text = ""
        authorLabel.text = ""
        yearLabel.text = ""
    }
    
   private func addSubviews(_ subview: [UIView]) {
        for item in subview {
            contentView.addSubview(item)
        }
    }
    
    private func setupElements() {
        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = 22

        bookImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.width.equalTo(150)
        }
       
        vStack.snp.makeConstraints { make in
            make.leading.equalTo(bookImageView.snp.trailing).offset(16)
            make.top.equalTo(contentView.snp.top).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.width.equalTo(250)

        }
    }
    
    func configure(with viewModel: Doc) {
        if let coverImage = viewModel.coverI {
            if coverImage > 0 {
                let urlString = "https://covers.openlibrary.org/b/id/" + "\(coverImage)" + "-M.jpg"
                let url = URL(string: urlString)
                bookImageView.sd_setImage(with: url)
            }
        } else {
            self.bookImageView.image = UIImage(named: "ImageNotFound")
        }
      
        self.bookTitleLabel.text = viewModel.titleSuggest
        
        if let name = viewModel.authorName {
            if !name.isEmpty {
                self.authorLabel.text = name[0]
                
                for (index, value) in name.enumerated() {
                    if index > 0 {
                        self.authorLabel.text = ((self.authorLabel.text) ?? "") + ", " + value
                    }
                }
            }
        }
        if let year = viewModel.firstPublishYear {
            self.yearLabel.text = "Published in " + "\(String(describing: year))"

        }
    }
}
