//
//  ListViewModel.swift
//  MobileChallenge
//
//  Created by Eduardo Oliveira on 10/01/22.
//

import Foundation

protocol ListViewModelType {
    var output: ListViewModelOutput? { get set }
    var listQuotes: [(code: String, description: String)]? { get set }
    
    func fetchQuotes(searchText: String)
    func numberOfRows() -> Int
    func cellText(index: Int) -> String
}

protocol ListViewModelOutput: AnyObject {
    func reloadDisplayData()
}

final class ListViewModel {
    private let repository = ApiRequest()
    
    public weak var output: ListViewModelOutput?
    var listQuotes: [(code: String, description: String)]? = []
}

extension ListViewModel: ListViewModelType {
    
    func fetchQuotes(searchText: String) {
        self.getListQuotes { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let listQuotes):
                self.listQuotes = listQuotes.sorted(by: { $0.code < $1.code })
                if searchText != "" {
                    self.listQuotes = self.listQuotes?.filter { quote in
                        return (quote.code.contains(searchText) || quote.description.contains(searchText))
                    }
                }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.output?.reloadDisplayData()
                }
            case .failure: break
            }
        }
    }
    
    func numberOfRows() -> Int {
        return self.listQuotes?.count ?? 0
    }
    
    func cellText(index: Int) -> String {
        return "\(self.listQuotes![index].code) - \(self.listQuotes![index].description)"
    }
    
    func getListQuotes(completion: @escaping (Result<[(code: String, description: String)], ApiRequestError>) -> Void) {
        repository.getListQuotes { response in
            switch response {
            case .success(let listQuotes):
                var codesAndDescriptions: [(code: String, description: String)] = []
                for currency in listQuotes.currencies {
                    codesAndDescriptions.append((code: currency.key, description: currency.value))
                }
                completion(.success(codesAndDescriptions))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
