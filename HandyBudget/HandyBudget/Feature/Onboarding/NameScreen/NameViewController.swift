//
//  ViewController.swift
//  HandyBudget
//
//  Created by Jadson on 13/11/2025.
//

import UIKit

class NameViewController: UIViewController {
    
//    let foo = "Poli"
    
    private lazy var nameView: NameView = {
        let view = NameView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home - Onboarding"
        nameView.delegate = self
    }
    
    override func loadView() {
        self.view = nameView
    }
    
}

extension NameViewController: NameViewDelegate {
    func nextButtonTapped() {
//        let viewController = CategorySelectionViewController(service: foo)
        let viewController = CategorySelectionViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
