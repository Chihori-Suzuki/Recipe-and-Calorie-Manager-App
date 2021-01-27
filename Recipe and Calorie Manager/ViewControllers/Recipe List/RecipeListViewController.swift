//
//  RecipeListViewController.swift
//  Recipe and Calorie Manager
//
//  Created by Kazunobu Someya on 2021-01-19.
//

import UIKit


class RecipeListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    let cellId = "RecipeListCell"
    // make variable to fill data from file
    var recipeList: [RecipeFinal] = []
    var meal: Meal!
    // make variable to set array for all meal types
    let category = Meal.allCases
    
    lazy var myTable: UITableView = {
        let table = UITableView(frame: view.frame, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        if let recipeList = RecipeFinal.loadFromList() {
            self.recipeList = recipeList
        }
    }
    
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
        return Meal.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        meal = category[indexPath.row]
        cell.textLabel?.text = meal.rawValue
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 0.5
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let clickedCategory = MenuTotalCalorieDetailListViewController()
        clickedCategory.mealTitle = category[indexPath.row].rawValue
        clickedCategory.selectedCategory = category[indexPath.row]
        navigationController?.pushViewController(clickedCategory, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
}
