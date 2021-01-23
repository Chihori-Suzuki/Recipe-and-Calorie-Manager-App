//
//  Nutrition.swift
//  Recipe and Calorie Manager
//
//  Created by Gil Jetomo on 2021-01-18.
//

import Foundation

struct Ingredient: Codable {
    var items: [Nutrition]
}

struct Nutrition: Codable {
    var sugar: Double
    var fiber: Double
    var serving: Double
    var sodium: Double
    var name: String
    var potassium: Double
    var fat: Double
    var totalFat: Double
    var calories: Double
    var cholesterol: Double
    var protein: Double
    var carbohydrates: Double
    
    enum CodingKeys: String, CodingKey  {
        case sugar = "sugar_g"
        case fiber = "fiber_g"
        case serving = "serving_size_g"
        case sodium = "sodium_mg"
        case name = "name"
        case potassium = "potassium_mg"
        case fat = "fat_saturated_g"
        case totalFat = "fat_total_g"
        case calories = "calories"
        case cholesterol = "cholesterol_mg"
        case protein = "protein_g"
        case carbohydrates = "carbohydrates_total_g"
    }
}

enum DailyValue: Double {
    case totalFat = 78.0
    case satFat = 20.0
    case cholesterol = 300.0
    case sodium = 2300.0
    case totalCarbs = 275.0
    case protein = 50.0
    case potassium = 4700.0
}
