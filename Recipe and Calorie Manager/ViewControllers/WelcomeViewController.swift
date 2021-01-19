//
//  ViewController.swift
//  Recipe and Calorie Manager
//
//  Created by Macbook Pro on 2021-01-18.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let welcomeLabel: UILabel = {
        let welcome = UILabel()
        welcome.font = UIFont(name: "Georgia", size: 30)
        welcome.numberOfLines = 0
        welcome.textAlignment = .center
        welcome.text = "Welcome to Recipe and Calorie Manager"
        welcome.translatesAutoresizingMaskIntoConstraints = false
        return welcome
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
//        NutritionAPI.shared.fetchNutritionInfo(query: "1 cup of rice")
        view.addSubview(welcomeLabel)
        setupConstraint()
    }
    
    func setupConstraint() {
         
        welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        welcomeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true

    }
}

