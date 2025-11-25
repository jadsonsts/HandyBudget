//
//  OnboardingService.swift
//  HandyBudget
//
//  Created by Jadson on 22/11/2025.
//

import Foundation

class OnboardingService {
    // 3 variaveis - 1 para nome, 1 para baseline, 1 para categorias selecionadas e nao selecionadas (priorizar categorias selecionadas)
    // func para UserDefaults salvar o nome
    
    // func para UserDefaults salvar a baseline
    
    var name: String = ""
    
    func setNome(_ nome: String) {
        self.name = nome
    }
    
    
    func salvaTudo() {
        func salvanome() {}
        func salvaBaseline() {}
        func salvaCategorias() {}
        func salvaConfig() {}
        
    }
}
