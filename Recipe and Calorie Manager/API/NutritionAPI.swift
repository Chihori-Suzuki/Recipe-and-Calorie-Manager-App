//
//  NutritionAPI.swift
//  Recipe and Calorie Manager
//
//  Created by Gil Jetomo on 2021-01-18.
//

import Foundation
import UIKit

class NutritionAPI {
  
  static let shared = NutritionAPI()
  
  private init() { }
   
    func fetchNutritionInfo(query: String, completion: @escaping (Result<Dataset, Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let url = URL(string: "https://api.calorieninjas.com/v1/nutrition?query="+query)!
        var request = URLRequest(url: url)
        request.setValue(API.key, forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
        
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let ingredient = try decoder.decode(Dataset.self, from: data)
                    completion(.success(ingredient))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
