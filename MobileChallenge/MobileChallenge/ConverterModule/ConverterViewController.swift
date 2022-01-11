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
        return button
    }()
    
    lazy var fromLabel: UILabel = {
        let label = UILabel()
        label.text = "From"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var toLabel: UILabel = {
        let label = UILabel()
        label.text = "To"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var fromTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Amount"
        let paddingView = UIView(frame: CGRect(x: 0 ,y: 0 ,width: 15 ,height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        return textField
    }()
    
    lazy var convertButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Convert", for: .normal)
        button.tintColor = .white
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        self.title = "Converter"
//        self.viewModel.fetchQuotes()
        
        self.view.addSubview(arrowImage)
        self.view.addSubview(fromButton)
        self.view.addSubview(toButton)
        self.view.addSubview(fromLabel)
        self.view.addSubview(toLabel)
        self.view.addSubview(fromTextField)
        self.view.addSubview(convertButton)
        
        configureConstraints()
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
            
            fromTextField.leadingAnchor.constraint(equalTo: fromButton.leadingAnchor),
            fromTextField.trailingAnchor.constraint(equalTo: toButton.trailingAnchor),
            fromTextField.heightAnchor.constraint(equalToConstant: 50),
            fromTextField.topAnchor.constraint(equalTo: arrowImage.bottomAnchor, constant: 25),
            
            convertButton.leadingAnchor.constraint(equalTo: fromTextField.leadingAnchor),
            convertButton.trailingAnchor.constraint(equalTo: fromTextField.trailingAnchor),
            convertButton.heightAnchor.constraint(equalToConstant: 50),
            convertButton.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 25)
            
        ])
    }
}

extension ConverterViewController: ConverterViewModelOutput {
    
}
