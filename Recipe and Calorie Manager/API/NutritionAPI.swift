//
//  NutritionAPI.swift
//  Recipe and Calorie Manager
//
//  Created by Macbook Pro on 2021-01-18.
//

import Foundation
import UIKit

class NutritionAPI {
  
  static let shared = NutritionAPI()
  
  private init() { }
   
    func fetchNutritionInfo(query: String) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = URL(string: "https://api.calorieninjas.com/v1/nutrition?query="+query)!
        var request = URLRequest(url: url)
        request.setValue(API.key, forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            do {
                let ingredient = try decoder.decode(Ingredient.self, from: data)
                print(ingredient.items)
            } catch {
                print(error)
            }
        }
        task.resume()
    }

}
