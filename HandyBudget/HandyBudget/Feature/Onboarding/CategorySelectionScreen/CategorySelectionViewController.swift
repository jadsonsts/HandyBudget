//
//  CategorySelectionViewController.swift
//  HandyBudget
//
//  Created by Jadson on 18/11/2025.
//

import UIKit

class CategorySelectionViewController: UIViewController {
    
    let service: String

    private lazy var categorySelectionView: CategorySelectionView = {
        let view = CategorySelectionView()
        return view
    }()
    
    init(service: String) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        let viewController = BaselineViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func categorySelected(category: CategoryModel) {
        print("Selected category: \(category.name) + \(category.iconName)")
    }
}
