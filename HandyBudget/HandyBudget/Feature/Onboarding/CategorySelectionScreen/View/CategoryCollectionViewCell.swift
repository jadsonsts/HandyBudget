//
//  CategoryCollectionViewCell.swift
//  HandyBudget
//
//  Created by Jadson on 19/11/2025.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "CategoryCollectionViewCell"
    
    override var isSelected: Bool {
        didSet {
            contentView.layer.borderColor = isSelected ? UIColor.appTeal.cgColor : UIColor.label.cgColor
            configureContent()
        }
    }
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconImageView, nameLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with category: CategoryModel) {
        iconImageView.image = UIImage(systemName: category.iconName)
        iconImageView.tintColor = .label
        nameLabel.text = category.name
    }
    
    private func configureContent() {
        nameLabel.textColor = isSelected ? .appTeal : .label
        iconImageView.tintColor = isSelected ? .appTeal : .label
    }
}

extension CategoryCollectionViewCell: ViewCode {
    func addSubViews() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func setupStyle() {
    
        contentView.layer.borderColor = UIColor.label.cgColor
        contentView.layer.borderWidth = 1.0
        contentView.layer.cornerRadius = 8.0
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
    }
    
}


