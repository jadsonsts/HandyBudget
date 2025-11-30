//
//  CategoryListView.swift
//  HandyBudget
//
//  Created by Jadson on 19/11/2025.
//

import UIKit

protocol CategoryCollectionViewDelegate: AnyObject {
    func didSelectCategory(_ category: CategoryModel)
}

class CategoryCollectionView: UICollectionView {
    
    weak var categoryDelegate: CategoryCollectionViewDelegate?
    
    let categories: [CategoryModel] = CategoryModel.initialCategories()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        backgroundColor = .clear
        delegate = self
        dataSource = self
        register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.cellIdentifier)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 35)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        self.init(frame: .zero, collectionViewLayout: layout)
    }
}

extension CategoryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.cellIdentifier, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: categories[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // priority selection logic will be here or view model?
        let selectedCategory = categories[indexPath.item]
        categoryDelegate?.didSelectCategory(selectedCategory)
    }
}

