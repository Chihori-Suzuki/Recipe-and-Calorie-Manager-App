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
//to be deprecated, tuple cannot conform to Codable
struct Recipe {
    var title: String
    var ingredients: [(serving: String, nutrition: Nutrition?)]
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
    
    static var draftURL: URL {
      let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      let draftURL = documentsURL.appendingPathComponent("recipe").appendingPathExtension("plist")
      return draftURL
    }
    
    static var archiveURL: URL {
      let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      let archiveURL = documentsURL.appendingPathComponent("recipeList").appendingPathExtension("plist")
      return archiveURL
    }

    static func saveToDraft(recipe: RecipeFinal) {
      let encoder = PropertyListEncoder()
      do {
        let encodedRecipe = try encoder.encode(recipe)
        try encodedRecipe.write(to: RecipeFinal.draftURL)
      } catch {
        print("Error encoding recipe: \(error.localizedDescription)")
      }
    }
    
    static func loadFromDraft() -> RecipeFinal? {
      guard let recipeData = try? Data(contentsOf: RecipeFinal.draftURL) else { return nil }
      
      do {
        let decoder = PropertyListDecoder()
        let decodedRecipe = try decoder.decode(RecipeFinal.self, from: recipeData)
        
        return decodedRecipe
      } catch {
        print("Error decoding recipe: \(error)")
        return nil
      }
    }
    
    static func deleteDraft() {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as NSString
        let destinationPath = documentsPath.appendingPathComponent("recipe.plist")
        do {
            try FileManager.default.removeItem(atPath: destinationPath)
        } catch {
            print("Error deleting draft: \(error.localizedDescription)")
        }
    }
}

enum Meal: String, Codable {
    case breakfast = "breakfast"
    case lunch = "lunch"
    case snack = "snack"
    case dinner = "dinner"
}
