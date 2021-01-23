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
struct Ingredient {
    var serving: String
    var nutrition: Nutrition
}
enum Meal: String {
    case breakfast = "breakfast"
    case lunch = "lunch"
    case snack = "snack"
    case dinner = "dinner"
}
