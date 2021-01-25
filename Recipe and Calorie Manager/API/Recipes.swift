//
//  Recipes.swift
//  Recipe and Calorie Manager
//
//  Created by Macbook Pro on 2021-01-21.
//

import Foundation

struct Catalog {
    var catalog: [RecipeList]
}
struct RecipeList {
    var category: Meal
    var recipes: [Recipe]
}
struct Recipe {
    var title: String
    var ingredients: [(serving: String, nutrition: Nutrition?)]
}
struct Ingredient: Equatable {
    var serving: String
    var nutrition: Nutrition
    
    static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        return lhs.serving.lowercased() == rhs.serving.lowercased()
    }
}
enum Meal: String {
    case breakfast = "breakfast"
    case lunch = "lunch"
    case snack = "snack"
    case dinner = "dinner"
}
