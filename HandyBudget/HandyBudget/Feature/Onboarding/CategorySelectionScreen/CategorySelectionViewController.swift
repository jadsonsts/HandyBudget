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
//        navigationController?.isNavigationBarHidden = true
    }
    
    override func loadView() {
        self.view = categorySelectionView
    }
    
}
