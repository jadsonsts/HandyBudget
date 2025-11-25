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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var askNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
//        let textField = FloatingPlaceholderTextField()
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
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
    
    
    // ASK POLI ABOUT THIS NEW BUTTON STYLE
    private lazy var nextButton2 = UIButton(
            configuration: .primary("Next"),
            primaryAction: .init(handler: { [weak self] _ in
                self?.delegate?.nextButtonTapped()
            })
        )

    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.appTeal, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [askNameLabel, nameTextField])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGesture)
        
        greetingLabel.text = "Welcome to HandyBudget.\n \nWe've changed a few bits on the app to make it easier for you to manage your finances, so let's get to know you better!"
        
        askNameLabel.text = "Let's start with your name:"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
    
    @objc internal func didTapNextButton() {
        delegate?.nextButtonTapped()
    }
}

extension NameView: ViewCode {
    func addSubViews() {
        addSubview(greetingLabel)
        addSubview(stackView)
        addSubview(nextButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            greetingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            greetingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            nextButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
            
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
