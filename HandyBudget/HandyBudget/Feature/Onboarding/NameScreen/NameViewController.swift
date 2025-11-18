//
//  ViewController.swift
//  HandyBudget
//
//  Created by Jadson on 13/11/2025.
//

import UIKit

class NameViewController: UIViewController {
    
    private lazy var nameView: NameView = {
        let view = NameView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Onboarding"
        nameView.delegate = self
    }
    
    override func loadView() {
        self.view = nameView
    }
    
}

extension NameViewController: NameViewDelegate {
    func nextButtonTapped() {
        let viewController = CategorySelectionViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
}
