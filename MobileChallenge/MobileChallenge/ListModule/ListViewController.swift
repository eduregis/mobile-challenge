//
//  ListViewController.swift
//  MobileChallenge
//
//  Created by Eduardo Oliveira on 10/01/22.
//

import Foundation
import UIKit

class ListViewController: UIViewController {
    
    var viewModel: ListViewModelType!
    var tableView = UITableView()
    private var avaliableQuotes = [(code: String, description: String)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(tableView)
        self.tableView.tableFooterView = UIView()
        self.title = "List"

        configureConstraints()
        
        viewModel.getAvaliableQuotes { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let avaliableQuotes):
                self.avaliableQuotes = avaliableQuotes
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.tableView.reloadData()
                }
                
            case .failure: break
//                self.handlerError(error) {
//                    self.navigationController?.popViewController(animated: true)
//                }
            }
        }
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

extension ListViewController: ListViewModelOutput {
//    func didFetchCoins(result: Result<String, ApiRequestError>) {
//        switch result {
//        case .success(let message):
//            print(message)
//            tableView.reloadData()
//        case .failure:
//            print("Ocorreu algum problema!")
//        }
//    }
    
}


extension ListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.avaliableQuotes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel?.text = self.avaliableQuotes[indexPath.row].code
        return cell
    }
}
