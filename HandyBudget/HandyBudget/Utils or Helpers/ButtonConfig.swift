//
//  ButtonConfig.swift
//  HandyBudget
//
//  Created by Jadson on 20/11/2025.
//

import UIKit

extension UIButton.Configuration {
    
    static func miniPrimary(_ title: String) -> UIButton.Configuration {
        var config = UIButton.Configuration.primary(title)
        config.buttonSize = .mini        
        return config
    }
        
    
    static func primary(_ title: String) -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .appTeal
        config.buttonSize = .large
        config.cornerStyle = .medium
        config.attributedTitle = AttributedString(title, attributes: .init([
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
        ]))

        return config
    }
    
    static func secondary(_ title: String) -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.baseForegroundColor = .appTeal
        config.baseBackgroundColor = .white
        config.buttonSize = .large
        config.cornerStyle = .medium
        config.attributedTitle = AttributedString(title, attributes: .init([
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
        ]))
        return config
    }
}

