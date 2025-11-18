//
//  CategorySelectionView.swift
//  HandyBudget
//
//  Created by Jadson on 18/11/2025.
//

import UIKit

class CategorySelectionView: UIView {
    
    private lazy var categoryDisclaimerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .label
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    // initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        categoryDisclaimerLabel.text = "Please select the categories that best describe your expenses. This will help us tailor your budgeting experience and prioritise the most used categories.\nDon't worry the categories not selected will be available at any time 😉"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategorySelectionView: ViewCode {
    func addSubViews() {
        addSubview(categoryDisclaimerLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryDisclaimerLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            categoryDisclaimerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            categoryDisclaimerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    func setupStyle() {
        backgroundColor = .appBackground
    }
    
    
}

