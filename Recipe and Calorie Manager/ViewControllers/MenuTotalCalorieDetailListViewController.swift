//
//  MenuTotalCalorieDetailListViewController.swift
//  Recipe and Calorie Manager
//
//  Created by Kazunobu Someya on 2021-01-20.
//

import UIKit

class MenuTotalCalorieDetailListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let addIngredients = AddIngredientsViewController()
    var selectedCategory: Int?
    
    // sample data
    var ingredientNutrition = Nutrition(sugar: 1, fiber: 1, serving: 1, sodium: 1, name: "onion", potassium: 1, fat: 1, totalFat: 1, calories: 1, cholesterol: 1, protein: 1, carbohydrates: 1)
    lazy var recipe1 = Recipe(title: "Breakfast Meal 1", ingredients: [(serving: "ingredient 1", nutrition: ingredientNutrition),
                                                                                         (serving: "ingredient 2", nutrition: ingredientNutrition)])
    lazy var recipe5 = Recipe(title: "Breakfast Meal 2", ingredients: [(serving: "ingredient 10", nutrition: ingredientNutrition)])
    lazy var recipe2 = Recipe(title: "Lunch Meal 1", ingredients: [(serving: "ingredient 2", nutrition: ingredientNutrition)])
    lazy var recipe3 = Recipe(title: "Dinner Meal 1", ingredients: [(serving: "ingredient 3", nutrition: ingredientNutrition)])
    lazy var recipe4 = Recipe(title: "Snack Meal 1", ingredients: [(serving: "ingredient 4", nutrition: ingredientNutrition)])

    lazy var breakfastMeals = RecipeList(category: .breakfast, recipes: [recipe1, recipe5])
    lazy var lunchMeals = RecipeList(category: .lunch, recipes: [recipe2])
    lazy var dinnerMeals = RecipeList(category: .dinner, recipes: [recipe3])
    lazy var snackMeals = RecipeList(category: .snack, recipes: [recipe4])
    lazy var catalog = Catalog(catalog: [breakfastMeals, lunchMeals, dinnerMeals, snackMeals])

    var mealTitle: String?

    lazy var totalCalorie: Double? = addIngredients.caloriesTotal
    


    let cellId = "MenuTotalCalorie"
    
    
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
        view.backgroundColor = .white
        title = mealTitle
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
        guard let selectCategory = selectedCategory else { return 0}
        return catalog.catalog[selectCategory].recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            
        guard let selectCategory = selectedCategory else { return UITableViewCell()}
        let cellTitle = catalog.catalog[selectCategory].recipes[indexPath.row].title
        let cellTotalCalories = catalog.catalog[selectCategory].recipes[indexPath.row].ingredients[indexPath.row].nutrition!.calories
        
        cell.textLabel?.text = "\(cellTitle) : \(cellTotalCalories ?? 0)"
        
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        return cell
    }
}
