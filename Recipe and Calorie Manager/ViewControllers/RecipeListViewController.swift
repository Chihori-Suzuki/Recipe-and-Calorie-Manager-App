//
//  RecipeListViewController.swift
//  Recipe and Calorie Manager
//
//  Created by Kazunobu Someya on 2021-01-19.
//

import UIKit


class RecipeListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    let meals: [String] = ["Breakfast","Lunch","Snacks","Dinner"]
    let cellId = "RecipeListCell"
    
    lazy var myTable: UITableView = {
        let table = UITableView(frame: view.frame, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "Recipe List"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(myTable)
        myTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        myTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        myTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        myTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let meal = meals[indexPath.row]
        cell.textLabel?.text = meal
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 0.5
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let clickedMeal = MenuTotalCalorieDetailListViewController()
        clickedMeal.mealTitle = meals[indexPath.row]
        navigationController?.pushViewController(clickedMeal, animated: true)
    }
}
