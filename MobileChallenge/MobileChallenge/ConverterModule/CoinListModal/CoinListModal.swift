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
    
    var fromOrTo: String!
    
    var viewModel: ConverterViewModelType!

    init(with viewModel: ConverterViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchQuotes(searchText: "") { () -> () in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.tableView.reloadData()
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(tableView)
        self.tableView.tableFooterView = UIView()
        self.title = "Choose a coin..."
        
//        self.hideKeyboardWhenTappedAround()

        configureConstraints()
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
        if ((fromOrTo == "from") && (viewModel.fromQuote?.code == cell.textLabel?.text)) || ((fromOrTo == "from") && (viewModel.fromQuote?.code == cell.textLabel?.text)) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedRow(quote: viewModel.liveQuotes![indexPath.row], fromOrTo: fromOrTo) { () -> () in
            dismiss(animated: true, completion: nil)
        }
    }
}
