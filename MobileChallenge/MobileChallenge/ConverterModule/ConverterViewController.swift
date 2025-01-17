//
//  ConverterViewController.swift
//  MobileChallenge
//
//  Created by Eduardo Oliveira on 10/01/22.
//

import Foundation
import UIKit

class ConverterViewController: UIViewController {
    
    var viewModel: ConverterViewModelType!
    
    lazy var arrowImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var fromButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Choose...", for: .normal)
        button.tintColor = .white
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(triggerFromListModal), for: .touchUpInside)
        return button
    }()
    
    lazy var toButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Choose...", for: .normal)
        button.tintColor = .white
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(triggerToListModal), for: .touchUpInside)
        return button
    }()
    
    lazy var fromLabel: UILabel = {
        let label = UILabel()
        label.text = "From"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var toLabel: UILabel = {
        let label = UILabel()
        label.text = "To"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var amountTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Amount"
        let paddingView = UIView(frame: CGRect(x: 0 ,y: 0 ,width: 15 ,height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        textField.delegate = self
        return textField
    }()
    
    lazy var convertButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Convert", for: .normal)
        button.tintColor = .white
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(triggerConvert), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    lazy var resultTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .systemGray6
        textField.isUserInteractionEnabled = false
        let paddingView = UIView(frame: CGRect(x: 0 ,y: 0 ,width: 15 ,height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        return textField
    }()
    
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Result"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        self.title = "Converter"
        
        
        self.view.addSubview(arrowImage)
        self.view.addSubview(fromButton)
        self.view.addSubview(toButton)
        self.view.addSubview(fromLabel)
        self.view.addSubview(toLabel)
        self.view.addSubview(amountTextField)
        self.view.addSubview(convertButton)
        self.view.addSubview(resultTextField)
        self.view.addSubview(resultLabel)
        
        self.hideKeyboardWhenTappedAround() 
        
        configureConstraints()
    }
    
    @objc func triggerFromListModal() {
        let fromListModal = CoinListModal(with: viewModel)
        fromListModal.fromOrTo = "from"
        let navFromListModal = UINavigationController()
        navFromListModal.viewControllers = [fromListModal]
        present(navFromListModal, animated: true, completion: nil)
    }
    
    @objc func triggerToListModal() {
        let fromListModal = CoinListModal(with: viewModel)
        fromListModal.fromOrTo = "to"
        let navFromListModal = UINavigationController()
        navFromListModal.viewControllers = [fromListModal]
        present(navFromListModal, animated: true, completion: nil)
    }
    
    @objc func triggerConvert() {
        if amountTextField.hasText {
            guard let amountText = amountTextField.text else { return }
            guard let fromQuote = viewModel.fromQuote else { return }
            guard let toQuote = viewModel.toQuote else { return }
            
            if let number = NumberFormatter().number(from: amountText) {
                let amount = CGFloat(truncating: number)
                let result = viewModel.convert(amount: amount, from: fromQuote, to: toQuote)
                
                resultTextField.text = "\(result)"
            }
        }
    }
    
    func enableConvert() {
        if viewModel.fromQuote != nil && viewModel.toQuote != nil {
            convertButton.isEnabled = true
            convertButton.backgroundColor = .systemBlue
        }
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            
            arrowImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            arrowImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            arrowImage.widthAnchor.constraint(equalToConstant: 50),
            arrowImage.heightAnchor.constraint(equalToConstant: 50),
            
            fromButton.centerYAnchor.constraint(equalTo: arrowImage.centerYAnchor),
            fromButton.heightAnchor.constraint(equalToConstant: 50),
            fromButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fromButton.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: -15),
            
            toButton.centerYAnchor.constraint(equalTo: arrowImage.centerYAnchor),
            toButton.heightAnchor.constraint(equalToConstant: 50),
            toButton.leadingAnchor.constraint(equalTo: arrowImage.trailingAnchor, constant: 15),
            toButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            fromLabel.centerXAnchor.constraint(equalTo: fromButton.centerXAnchor),
            fromLabel.bottomAnchor.constraint(equalTo: fromButton.topAnchor, constant: -5),
            
            toLabel.centerXAnchor.constraint(equalTo: toButton.centerXAnchor),
            toLabel.bottomAnchor.constraint(equalTo: toButton.topAnchor, constant: -5),
            
            amountTextField.leadingAnchor.constraint(equalTo: fromButton.leadingAnchor),
            amountTextField.trailingAnchor.constraint(equalTo: toButton.trailingAnchor),
            amountTextField.heightAnchor.constraint(equalToConstant: 50),
            amountTextField.topAnchor.constraint(equalTo: arrowImage.bottomAnchor, constant: 25),
            
            convertButton.leadingAnchor.constraint(equalTo: amountTextField.leadingAnchor),
            convertButton.trailingAnchor.constraint(equalTo: amountTextField.trailingAnchor),
            convertButton.heightAnchor.constraint(equalToConstant: 50),
            convertButton.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 25),
            
            resultTextField.leadingAnchor.constraint(equalTo: convertButton.leadingAnchor),
            resultTextField.trailingAnchor.constraint(equalTo: convertButton.trailingAnchor),
            resultTextField.heightAnchor.constraint(equalToConstant: 60),
            resultTextField.topAnchor.constraint(equalTo: convertButton.bottomAnchor, constant: 35),
            
            resultLabel.leadingAnchor.constraint(equalTo: resultTextField.leadingAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: resultTextField.topAnchor, constant: -3)
        ])
    }
}

extension ConverterViewController: ConverterViewModelOutput {
    func reloadDisplayData() {
        self.viewModel.fetchQuotes(searchText: "") {
            if viewModel.fromQuote?.code != "000" {
                fromButton.setTitle("\(viewModel.fromQuote?.code.suffix(3) ?? "")", for: .normal)
            }
            if viewModel.toQuote?.code != "000" {
                toButton.setTitle("\(viewModel.toQuote?.code.suffix(3) ?? "")", for: .normal)
            }
            enableConvert()
        }
    }
}

extension ConverterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789.").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
