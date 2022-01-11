//
//  CoinListModal.swift
//  MobileChallenge
//
//  Created by Eduardo Oliveira on 11/01/22.
//

import Foundation
import UIKit

class CoinListModal: UIViewController {
    
    var tableView = UITableView()
    let searchController = UISearchController()
    
//    var fromOrTo: String!
    var actualSearchText: String = ""
    
    var viewModel: ConverterViewModelType!

//    init(with viewModel: ConverterViewModelType) {
//        super.init(nibName: nil, bundle: nil)
//        self.viewModel = viewModel
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        
        self.view.addSubview(tableView)
        self.tableView.tableFooterView = UIView()
        self.title = "Choose a coin..."

        configureConstraints()
    
        viewModel.fetchQuotes(searchText: "")
    }
    
    func configureConstraints() {
        tableView.contentOffset = CGPoint(x: -18, y: -18)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CoinListModal: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel?.text = self.viewModel.cellText(index: indexPath.row)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        dismiss(animated: true, completion: { [self] in
//            self.viewModel.selectedRow(index: indexPath.row, fromOrTo: fromOrTo)
//        })
//    }
}

extension CoinListModal: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        self.actualSearchText = searchText
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            if self.actualSearchText == searchText {
                self.viewModel.fetchQuotes(searchText: searchText)
            }
        }
    }
}

extension CoinListModal: ConverterViewModelOutput {
    func reloadDisplayData() {
        tableView.reloadData()
    }
}
