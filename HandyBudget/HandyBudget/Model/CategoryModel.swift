//
//  CategoryModel.swift
//  HandyBudget
//
//  Created by Jadson on 19/11/2025.
//

struct CategoryModel {
    let name: String
    let iconName: String
    let priority: Int
}

extension CategoryModel {
    static func sampleCategories() -> [CategoryModel] {
        return [
            CategoryModel(name: "Food", iconName: "fork.knife", priority: 0),
            CategoryModel(name: "Transport", iconName: "car", priority: 0),
            CategoryModel(name: "Shopping", iconName: "bag", priority: 0),
            CategoryModel(name: "Health", iconName: "heart", priority: 0),
            CategoryModel(name: "Education", iconName: "book", priority: 0),
            CategoryModel(name: "Entertainment", iconName: "gamecontroller", priority: 0),
            CategoryModel(name: "Travel", iconName: "airplane", priority: 0),
            CategoryModel(name: "Bills", iconName: "doc.text", priority: 0),
            CategoryModel(name: "Savings", iconName: "banknote", priority: 0),
            CategoryModel(name: "Gifts", iconName: "gift", priority: 0),
            CategoryModel(name: "Groceries", iconName: "cart", priority: 0),
            CategoryModel(name: "Fitness", iconName: "figure.walk", priority: 0),
            CategoryModel(name: "Pets", iconName: "pawprint", priority: 0),
            CategoryModel(name: "Beauty", iconName: "scissors", priority: 0),
            CategoryModel(name: "Home", iconName: "house", priority: 0),
            CategoryModel(name: "Insurance", iconName: "shield", priority: 0),
            CategoryModel(name: "Investments", iconName: "chart.bar", priority: 0),
            CategoryModel(name: "Kids", iconName: "person.2", priority: 0),
            CategoryModel(name: "Clothing", iconName: "tshirt", priority: 0),
            CategoryModel(name: "Miscellaneous", iconName: "ellipsis", priority: 0),
            CategoryModel(name: "Rent", iconName: "house.fill", priority: 0),
            CategoryModel(name: "Mortgage", iconName: "building.columns", priority: 0)
        ]
    }
}
