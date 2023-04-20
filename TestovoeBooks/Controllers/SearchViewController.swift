//
//  ViewController.swift
//  TestovoeBooks
//
//  Created by MacBook Air on 18.04.2023.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    let networkService = NetworkService()
   @MainActor var bookArray: [Doc] = []
    
   @MainActor private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
        table.selectionFollowsFocus = false
        return table
    }()
    
    lazy var searchLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.text = "No search yet"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var noResultsLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.text = "No results"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var searchBar: UISearchBar = {
      let search = UISearchBar()
        search.placeholder = "Введите название книги или имя автора"
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        self.title = "Library"
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = searchLabel
        tableView.backgroundView?.contentMode = .scaleAspectFit
        setupUI()
    }
    
    func setupUI() {
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)

        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.bookArray = []
            self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        Task {
            do {
                let result = try await networkService.fetchBooks(by: searchBar.text!)
                self.bookArray.append(contentsOf: result.docs)
                tableView.reloadData()
            } catch {
                self.tableView.backgroundView = noResultsLabel
                self.tableView.backgroundView?.contentMode = .scaleAspectFit
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.backgroundView = searchLabel
        tableView.backgroundView?.contentMode = .scaleAspectFit
    }
}

