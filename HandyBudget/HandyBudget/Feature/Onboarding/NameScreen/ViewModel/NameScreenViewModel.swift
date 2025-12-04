//
//  NameScreenViewModel.swift
//  HandyBudget
//
//  Created by Jadson on 04/12/2025.
//

import Foundation

enum ValidationResult {
    case valid
    case invalid(message: String)
}

protocol NameScreenViewModelProtocol {
    var name: String { get set }
    func validateName() -> ValidationResult
    var navigationTitle: String { get }
}

class NameScreenViewModel: NameScreenViewModelProtocol {
    var name: String = ""
    let navigationTitle = "Home - Onboarding"
    
    func validateName() -> ValidationResult {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty else {
            return .invalid(message: "Name cannot be empty.")
        }
        
        guard trimmedName.count >= 2 else {
            return .invalid(message: "Name must be at least 2 characters long.")
        }
        
        let invalidCharacters = CharacterSet.letters.union(.whitespaces).inverted
        if trimmedName.rangeOfCharacter(from: invalidCharacters) != nil {
            return .invalid(message: "Name contains invalid characters.")
        }
        
        return .valid
    }
}

