//
//  ConverterViewModel.swift
//  MobileChallenge
//
//  Created by Eduardo Oliveira on 10/01/22.
//

import Foundation

protocol ConverterViewModelType {
    var output: ConverterViewModelOutput? { get set }
    var liveQuotes: [(code: String, rate: Float)]? { get set }
    
    func fetchQuotes()
}

protocol ConverterViewModelOutput: AnyObject {
    
}

final class ConverterViewModel {
    private let repository = ApiRequest()
    
    public weak var output: ConverterViewModelOutput?
    var liveQuotes: [(code: String, rate: Float)]? = []
}

extension ConverterViewModel: ConverterViewModelType {
    
    func fetchQuotes() {
        self.getLiveQuotes { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let liveQuotes):
                self.liveQuotes = liveQuotes.sorted(by: { $0.code < $1.code })
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    print(self.liveQuotes)
                }
            case .failure: break
            }
        }
    }
    
    func getLiveQuotes(completion: @escaping (Result<[(code: String, rate: Float)], ApiRequestError>) -> Void) {
        repository.getLiveQuotes { response in
            switch response {
            case .success(let liveQuotes):
                var codesAndRates: [(code: String, rate: Float)] = []
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
