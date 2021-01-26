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
    
    //TEMPORARY IMPLEMENTATION
    static var isDraft = true
}
struct Ingredient: Equatable, Codable {
    var serving: String
    var nutrition: Nutrition
    
    static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        return lhs.serving.lowercased() == rhs.serving.lowercased()
    }
}

struct RecipeFinal: Codable {
    var title: String
    var meal: Meal
    var ingredients: [Ingredient]
    
    static var archiveURL: URL {
      let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      let archiveURL = documentsURL.appendingPathComponent("recipe").appendingPathExtension("plist")
      
      return archiveURL
    }
    
    static func deleteFile() {

    }
    
    static func saveToFile(recipe: RecipeFinal) {
      let encoder = PropertyListEncoder()
      do {
        let encodedRecipe = try encoder.encode(recipe)
        try encodedRecipe.write(to: RecipeFinal.archiveURL)
      } catch {
        print("Error encoding emojis: \(error.localizedDescription)")
      }
    }
    
    static func loadFromFile() -> RecipeFinal? {
      guard let recipeData = try? Data(contentsOf: RecipeFinal.archiveURL) else { return nil }
      
      do {
        let decoder = PropertyListDecoder()
        let decodedRecipe = try decoder.decode(RecipeFinal.self, from: recipeData)
        
        return decodedRecipe
      } catch {
        print("Error decoding emojis: \(error)")
        return nil
      }
    }
}

enum Meal: String, Codable {
    case breakfast = "breakfast"
    case lunch = "lunch"
    case snack = "snack"
    case dinner = "dinner"
}
