//
//  Nutrition.swift
//  Recipe and Calorie Manager
//
//  Created by Macbook Pro on 2021-01-18.
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


