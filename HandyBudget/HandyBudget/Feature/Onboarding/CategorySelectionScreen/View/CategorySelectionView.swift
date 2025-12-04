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
    
    private lazy var categoryExplanationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var categoryCollectionView: UICollectionView = {
        let collectionView = CategoryCollectionView()
        collectionView.backgroundColor = .clear
        collectionView.allowsMultipleSelection = true // Enable multiple selection
        collectionView.layer.cornerRadius = 10
        collectionView.layer.masksToBounds = true //remove later
        collectionView.layer.borderWidth = 1.0 // remove later
        collectionView.layer.borderColor = UIColor.systemRed.cgColor //remove later
        collectionView.categoryDelegate = self
        return collectionView
    }()
    
    private lazy var nextButton = UIButton(
        configuration: .primary("Next"),
        primaryAction: .init(handler: { [weak self] _ in
        self?.delegate?.nextButtonTapped()
    }))

    
    // initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        categoryExplanationLabel.text = "Please select the categories that best describe your expenses. This will help us tailor your budgeting experience and prioritise the most used categories."
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategorySelectionView: ViewCode {
    func addSubViews() {
        addSubview(categoryExplanationLabel)
        addSubview(categoryCollectionView)
        addSubview(nextButton)
    }
    
    func setupConstraints() {
        
        categoryExplanationLabel
            .fillHorizontally()
            .setConstraint([
                categoryExplanationLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)
            ])
        
        categoryCollectionView
            .fillHorizontally()
            .setConstraint([
            categoryCollectionView.topAnchor.constraint(equalTo: categoryExplanationLabel.bottomAnchor, constant: 20),
            categoryCollectionView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -25)
        ])
        
        nextButton
            .fillHorizontally()
            .setConstraint([
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

