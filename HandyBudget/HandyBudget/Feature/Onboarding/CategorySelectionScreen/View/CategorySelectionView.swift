//
//  CategorySelectionView.swift
//  HandyBudget
//
//  Created by Jadson on 18/11/2025.
//

import UIKit

protocol CategoryViewDelegate: AnyObject {
    func nextButtonTapped()
    func categorySelected(category: CategoryModel)
}

class CategorySelectionView: UIView {
    
    weak var delegate: CategoryViewDelegate?
    
    private lazy var categoryDisclaimerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .label
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var categoryCollectionView: UICollectionView = {
        let collectionView = CategoryCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.allowsMultipleSelection = true // Enable multiple selection
        collectionView.layer.cornerRadius = 10
        collectionView.layer.masksToBounds = true //remove later
        collectionView.layer.borderWidth = 1.0 // remove later
        collectionView.layer.borderColor = UIColor.systemRed.cgColor //remove later
        collectionView.categoryDelegate = self
        return collectionView
    }()
    
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
    
    // initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        categoryDisclaimerLabel.text = "Please select the categories that best describe your expenses. This will help us tailor your budgeting experience and prioritise the most used categories."
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc internal func didTapNextButton() {
        delegate?.nextButtonTapped()
    }
}

extension CategorySelectionView: ViewCode {
    func addSubViews() {
        addSubview(categoryDisclaimerLabel)
        addSubview(categoryCollectionView)
        addSubview(nextButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryDisclaimerLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            categoryDisclaimerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            categoryDisclaimerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            categoryCollectionView.topAnchor.constraint(equalTo: categoryDisclaimerLabel.bottomAnchor, constant: 20),
            categoryCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            categoryCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            categoryCollectionView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -50),
            
            nextButton.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: -50),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    func setupStyle() {
        backgroundColor = .appBackground
    }
}

extension CategorySelectionView: CategoryCollectionViewDelegate {
    func didSelectCategory(_ category: CategoryModel) {
        delegate?.categorySelected(category: category)
    }
}

