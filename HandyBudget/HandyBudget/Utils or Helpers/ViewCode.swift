//
//  ViewCode.swift
//  HandyBudget
//
//  Created by Jadson on 17/11/2025.
//

protocol ViewCode {
    func addSubViews()
    func setupConstraints()
    func setupStyle()
    
}

extension ViewCode {
    func setup() {
        addSubViews()
        setupConstraints()
        setupStyle()
    }
}

