//
//  ButtonConfig.swift
//  HandyBudget
//
//  Created by Jadson on 20/11/2025.
//

import UIKit

extension UIButton.Configuration {
    static func primary(_ title: String) -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .appTeal
        config.cornerStyle = .medium
        config.attributedTitle = AttributedString(title, attributes: .init([
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
        ]))
        return config
    }
    
//    static func secondary(_ title: String) -> UIButton.Configuration {
//        var config = UIButton.Configuration.bordered()
//        config.title = title
//        config.baseForegroundColor = .appTeal
//        config.cornerStyle = .medium
//        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20)
//        return config
//    }
}

