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
        view.backgroundColor = .blue
        NutritionAPI.shared.fetchNutritionInfo(query: "1 cup of rice")
    }


}

