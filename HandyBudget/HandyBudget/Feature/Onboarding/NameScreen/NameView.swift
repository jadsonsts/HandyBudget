//
//  NameView.swift
//  HandyBudget
//
//  Created by Jadson on 17/11/2025.
//
import UIKit

protocol NameViewDelegate: AnyObject {
    func nextButtonTapped()
}

class NameView: UIView {
    
    weak var delegate: NameViewDelegate?
    
    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var askNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
//        let textField = FloatingPlaceholderTextField()
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Name"
        textField.backgroundColor = .appTeal
        textField.returnKeyType = .done
        textField.delegate = self
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    
    private lazy var nextButton = UIButton(
            configuration: .primary("Next"),
            primaryAction: .init(handler: { [weak self] _ in
                self?.didTapNextButton()
            })
        )
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [askNameLabel, nameTextField])
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGesture)
        
        greetingLabel.text = "Welcome to HandyBudget.\n \nIn order to give you the best experience, we would like to ask you a few questions."
        
        askNameLabel.text = "Let's start with your name:"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
    
    func didTapNextButton() {
        delegate?.nextButtonTapped()
        nameTextField.resignFirstResponder()
    }
}

extension NameView: ViewCode {
    func addSubViews() {
        addSubview(greetingLabel)
        addSubview(stackView)
        addSubview(nextButton)
    }
    
    func setupConstraints() {
        
        greetingLabel
            .fillHorizontally()
            .setConstraint([
                greetingLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
        
        stackView
            .fillHorizontally()
            .setConstraint([
                stackView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 30)
        ])
        
        nextButton
            .fillHorizontally()
            .setConstraint([
                nextButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50)
                //check if it's better to leave the button at the bottom and make it goes up when keyboard appears
            ])
    }
    
    func setupStyle() {
        backgroundColor = .appTeal
    }
}

extension NameView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension NameView: NameViewDelegate {
    func nextButtonTapped() {
        delegate?.nextButtonTapped()
    }
    
}
