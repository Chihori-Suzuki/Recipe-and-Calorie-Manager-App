//
//  Recipes.swift
//  Recipe and Calorie Manager
//
//  Created by Macbook Pro on 2021-01-21.
//

import Foundation

struct Recipes {
    var meal: Meal
    var ingredients: [(serving: String, nutrition: Nutrition?)]
}

enum Meal: String {
    case breakfast = "breakfast"
    case lunch = "lunch"
    case snack = "snack"
    case dinner = "dinner"
}