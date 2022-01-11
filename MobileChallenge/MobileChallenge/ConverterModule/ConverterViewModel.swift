//
//  ConverterViewModel.swift
//  MobileChallenge
//
//  Created by Eduardo Oliveira on 10/01/22.
//

import Foundation
import UIKit

protocol ConverterViewModelType {
    var output: ConverterViewModelOutput? { get set }
    var liveQuotes: [(code: String, rate: CGFloat)]? { get set }
    
    var fromQuoteIndex: Int? { get set }
    var toQuoteIndex: Int? { get set }
    
    func fetchQuotes(searchText: String, completion: () -> ())
    func convert(amount: CGFloat, from: (code: String, rate: CGFloat), to: (code: String, rate: CGFloat)) -> CGFloat
    func numberOfRows() -> Int
    func cellText(index: Int) -> String
    func selectedRow(index: Int, fromOrTo: String, completion: () -> ())
}

protocol ConverterViewModelOutput: AnyObject {
    func reloadDisplayData()
}

final class ConverterViewModel {
    private let repository = ApiRequest()
    
    public weak var output: ConverterViewModelOutput?
    var liveQuotes: [(code: String, rate: CGFloat)]? = []
    
    var fromQuoteIndex: Int? = -1
    var toQuoteIndex: Int? = -1
}

extension ConverterViewModel: ConverterViewModelType {
    func fetchQuotes(searchText: String, completion: () -> ()) {
        self.getLiveQuotes { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let liveQuotes):
                self.liveQuotes = liveQuotes.sorted(by: { $0.code < $1.code })
                if searchText != "" {
                    self.liveQuotes = self.liveQuotes?.filter { quote in
                        return quote.code.contains(searchText.uppercased())
                    }
                }
            case .failure: break
            }
        }
        completion()
    }
    
    func convert(amount: CGFloat, from: (code: String, rate: CGFloat), to: (code: String, rate: CGFloat)) -> CGFloat {
        return amount * (to.rate / from.rate)
    }
    
    func numberOfRows() -> Int {
        return self.liveQuotes?.count ?? 0
    }
    
    func cellText(index: Int) -> String {
        let code = self.liveQuotes![index].code
        return "\(code.suffix(3))"
    }
    
    func selectedRow(index: Int, fromOrTo: String, completion: () -> ()) {
        if fromOrTo == "from" {
            fromQuoteIndex = index
        } else if fromOrTo == "to" {
            toQuoteIndex = index
        }
        completion()
        self.output?.reloadDisplayData()
    }
    
    func getLiveQuotes(completion: @escaping (Result<[(code: String, rate: CGFloat)], ApiRequestError>) -> Void) {
        repository.getLiveQuotes { response in
            switch response {
            case .success(let liveQuotes):
                
                var codesAndRates: [(code: String, rate: CGFloat)] = []
                for quote in liveQuotes.quotes {
                    codesAndRates.append((code: quote.key, rate: quote.value))
                }
                completion(.success(codesAndRates))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
