//
//  UIViewHelper.swift
//  HandyBudget
//
//  Created by Jadson on 27/11/2025.
//

import UIKit

extension UIView {
    func setConstraint(_ constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    
    @discardableResult
    func fillHorizontally(constant: CGFloat = 16) -> Self {
        guard let superview else { return self }
        setConstraint([
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant)
        ])
        return self
    }
    
    @discardableResult
    func allignVerticalCenter() -> Self {
        guard let superview else { return self }
        setConstraint([
            self.centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])
        return self
    }
    
}
