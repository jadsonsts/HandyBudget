//
//  OnboardingService.swift
//  HandyBudget
//
//  Created by Jadson on 22/11/2025.
//

import Foundation
import CoreData

class OnboardingService {
    // 3 variaveis - 1 para nome, 1 para baseline, 1 para categorias selecionadas e nao selecionadas (priorizar categorias selecionadas)
    // func para UserDefaults salvar o nome
    
    // func para UserDefaults salvar a baseline
    
    let manager = CoreDataStack.shared
    
    var name: String = ""
    var categories: [CategoryModel] = []
    var baseline: (type: BaselineCycle, endDay: Weekday)? // ta tudo confuso isso aqui - rever depois
    
    func setName(_ name: String) {
        self.name = name
    }
    
    func setCategory(_ categories: [CategoryModel]) {
        self.categories = categories
    }
    
    func setBaseline(cylceType: BaselineCycle, value: Weekday) { //rever isso tambem
        self.baseline = (cylceType, value)
    }
    
    func saveOnboardingSettings() {
        saveName(name: name)
        saveBaseline()
        saveCategories()
        
    }
    
    func saveName(name: String) {
        UserDefaults.standard.set(name, forKey: "userName")
    }
    
    func saveBaseline() {
//        guard let baseline = baseline else { return }
        //save it in coredata
        
        let baseline: Baseline = .init(context: manager.context) //correct way?
        
        baseline.baselineType = "Weekly"
        baseline.baselineValue = "Monday"
        
        manager.saveContext()
        
    }
    
    func saveCategories() {
//        let categoryNames = categories.map { $0.name }
    }
}
