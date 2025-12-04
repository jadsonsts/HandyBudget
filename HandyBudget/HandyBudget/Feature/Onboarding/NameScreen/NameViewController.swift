//
//  ViewController.swift
//  HandyBudget
//
//  Created by Jadson on 13/11/2025.
//

import UIKit

class NameViewController: UIViewController {
    
    let onboardingService = OnboardingService()
    
    private lazy var nameView: NameView = {
        let view = NameView()
        return view
    }()
    
    private var viewModel: NameScreenViewModelProtocol
    
    init(viewModel: NameScreenViewModelProtocol = NameScreenViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.navigationTitle
        nameView.delegate = self
    }
    
    override func loadView() {
        self.view = nameView
    }
}

extension NameViewController: NameViewDelegate {
    func nextButtonTapped() {
        guard let name = nameView.getName() else { return }
        
        viewModel.name = name
        
        let validation = viewModel.validateName()
        switch validation {
            case .valid:
                onboardingService.setName(name)
                proceedToNextScreen()
                
                print("Name entered: \(name)")
                
            case .invalid(message: let message):
                let alert = nameView.createAlertForEmptyName(message)
                present(alert, animated: true, completion: nil)
        }
    }
    
    func proceedToNextScreen() {
        let viewController = CategorySelectionViewController(onboardingService: onboardingService)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
