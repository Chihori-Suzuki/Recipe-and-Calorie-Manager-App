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
    var recipeList: [Recipe] = []
    var meal: Meal!
    // make variable to set array for all meal types
    let category = Meal.allCases
    
    lazy var myTable: UITableView = {
        let table = UITableView(frame: view.frame, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        table.backgroundColor = UIColor.Theme1.white
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        if let recipeList = Recipe.loadFromList() {
            self.recipeList = recipeList
        }
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Theme1.blue, NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 30)!]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Theme1.white
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
        cell.textLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 26)
        cell.textLabel?.textColor = UIColor.Theme1.brown
        cell.backgroundColor = UIColor.Theme1.white
        let chevronImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        chevronImageView.image = UIImage(named: "right-chevron")
        chevronImageView.image = chevronImageView.image?.withRenderingMode(.alwaysTemplate)
        chevronImageView.tintColor = UIColor.Theme1.green
        cell.accessoryView = chevronImageView
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
        return 45.0
    }
}
