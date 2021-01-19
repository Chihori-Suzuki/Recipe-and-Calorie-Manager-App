//
//  ViewController.swift
//  Recipe and Calorie Manager
//
//  Created by Macbook Pro on 2021-01-18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let query = "3lb carrots and a chicken sandwich".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.calorieninjas.com/v1/nutrition?query="+query!)!
        var request = URLRequest(url: url)
        request.setValue(API.key, forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }

            let decoder = JSONDecoder()
              do {
                let ingredient = try decoder.decode(Ingredient.self, from: data)
                print(ingredient.items)
//                for nutrition in ingredient.items {
//                    print(nutrition.calories)
//                }
              } catch {
                print(error)
              }
        }
        task.resume()
    }


}

