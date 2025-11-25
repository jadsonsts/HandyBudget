//
//  BaselineViewController.swift
//  HandyBudget
//
//  Created by Jadson on 20/11/2025.
//

//
//  ViewController.swift
//  HandyBudget
//
//  Created by Jadson on 13/11/2025.
//

import UIKit

class BaselineViewController: UIViewController {
    

    private lazy var baselineView: BaselineView = {
        let view = BaselineView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Baseline - Onboarding"

    }
    
    override func loadView() {
        self.view = baselineView
    }
    
}
