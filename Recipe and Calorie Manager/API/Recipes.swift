//
//  Recipes.swift
//  Recipe and Calorie Manager
//
//  Created by Gil Jetomo on 2021-01-21.
//

import Foundation

enum Meal: String, Codable, CaseIterable {
    case breakfast = "breakfast"
    case lunch = "lunch"
    case snack = "snack"
    case dinner = "dinner"
}
struct Ingredient: Equatable, Codable {
    var serving: String
    var nutrition: Nutrition
    
    static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        return lhs.serving.lowercased() == rhs.serving.lowercased()
    }
}
struct Recipe: Codable, Equatable {
    var title: String
    var meal: Meal
    var ingredients: [Ingredient]
    
    static var newRecipeCount = 0
    static var newBreakfastCount = 0
    static var newLunchCount = 0
    static var newSnackCount = 0
    static var newDinnerCount = 0
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.title.lowercased() == rhs.title.lowercased() && lhs.meal == rhs.meal && lhs.ingredients == rhs.ingredients
    }
    private static let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    private static var draftURL: URL {
        let draftURL = Recipe.documentsURL.appendingPathComponent("recipe").appendingPathExtension("plist")
      return draftURL
    }
    private static var archiveURL: URL {
        let archiveURL = Recipe.documentsURL.appendingPathComponent("recipeList").appendingPathExtension("plist")
      return archiveURL
    }
    static func saveToDraft(recipe: Recipe) {
      let encoder = PropertyListEncoder()
      do {
        let encodedRecipe = try encoder.encode(recipe)
        try encodedRecipe.write(to: Recipe.draftURL)
      } catch {
        print("Error encoding recipe: \(error.localizedDescription)")
      }
    }
    static func loadFromDraft() -> Recipe? {
      guard let recipeData = try? Data(contentsOf: Recipe.draftURL) else { return nil }
      do {
        let decoder = PropertyListDecoder()
        let decodedRecipe = try decoder.decode(Recipe.self, from: recipeData)
        return decodedRecipe
      } catch {
        print("Error decoding recipe: \(error)")
        return nil
      }
    }
    static func saveToList(recipes: [Recipe]) {
      let encoder = PropertyListEncoder()
      do {
        let encodedRecipe = try encoder.encode(recipes)
        try encodedRecipe.write(to: Recipe.archiveURL)
      } catch {
        print("Error encoding recipe: \(error.localizedDescription)")
      }
    }
    static func loadFromList() -> [Recipe]? {
      guard let recipeData = try? Data(contentsOf: Recipe.archiveURL) else { return nil }
      do {
        let decoder = PropertyListDecoder()
        let decodedRecipes = try decoder.decode([Recipe].self, from: recipeData)

        return decodedRecipes
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
