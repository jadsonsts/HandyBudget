//
//  CategorySelectionViewController.swift
//  HandyBudget
//
//  Created by Jadson on 18/11/2025.
//

import UIKit

class CategorySelectionViewController: UIViewController {

    private lazy var categorySelectionView: CategorySelectionView = {
        let view = CategorySelectionView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Categories - Onboarding"
        categorySelectionView.delegate = self
    }
    
    override func loadView() {
        self.view = categorySelectionView
    
    }
    
}
extension CategorySelectionViewController: CategoryViewDelegate {
    func nextButtonTapped() {
        // Proceed to the next step in onboarding
    }
    
    func categorySelected(category: CategoryModel) {
        print("Selected category: \(category.name) + \(category.iconName)")
    }
}
