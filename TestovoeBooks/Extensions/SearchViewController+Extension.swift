//
//  SearchViewController+Extension.swift
//  TestovoeBooks
//
//  Created by MacBook Air on 20.04.2023.
//

import Foundation
import UIKit

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        
        let newViewModel = bookArray[indexPath.row]
        cell.configure(with: newViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let catalog = self.bookArray[indexPath.row]
        let viewModel = BookViewModel(book: catalog)
        let viewController = BookDescriptionViewController(viewModel)
        navigationController?.present(viewController, animated: true)
    }
}
