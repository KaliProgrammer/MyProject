//
//  BookView.swift
//  TestovoeBooks
//
//  Created by MacBook Air on 20.04.2023.
//

import Foundation
import UIKit
import SnapKit

class BookView: UIView {
    
    lazy var bookImage: UIImageView = {
       let bookView = UIImageView()
       bookView.layer.cornerRadius = 12
       bookView.layer.masksToBounds = true
       return bookView
   }()
    
    lazy var bookNameLabel: UILabel = {
       let label = UILabel()
       label.numberOfLines = 0
       label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
       label.backgroundColor = .white
       return label
   }()
    
    lazy var authorNameLabel: UILabel = {
       let label = UILabel()
       label.numberOfLines = 0
       label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
       label.backgroundColor = .white
       return label
   }()
    
    lazy var publishedYearLabel: UILabel = {
       let label = UILabel()
       label.numberOfLines = 0
       label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
       label.backgroundColor = .white
       return label
   }()
    
    lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            bookNameLabel,
            authorNameLabel,
            publishedYearLabel
        ])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImage()
        setupStack()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setuo UI Functions
    
     func setupImage() {
         self.addSubview(bookImage)
         bookImage.snp.makeConstraints { make in
             make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(16)
             make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(80)
             make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-80)
             make.height.equalTo(300)
         }
    }
    
    func setupStack() {
        self.addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.top.equalTo(bookImage.snp.bottom).offset(20)
            make.centerX.equalTo(self.snp.centerX)
            make.leading.equalTo(self.snp.leading).offset(16)
            make.trailing.equalTo(self.snp.trailing).offset(-16)
            make.height.equalTo(150)
        }
   }
}
