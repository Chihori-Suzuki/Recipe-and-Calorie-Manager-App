//
//  RecipeListViewController.swift
//  Recipe and Calorie Manager
//
//  Created by Kazunobu Someya on 2021-01-19.
//

import UIKit


class RecipeListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    // make nutrition object
    var ingredientNutrition = Nutrition(sugar: 1.0, fiber: 1, serving: 1, sodium: 1, name: "onion", potassium: 1, fat: 1, totalFat: 1, calories: 1.0, cholesterol: 1, protein: 1, carbohydrates: 1)
    // make ingredient object
    lazy var ingredient = Ingredient(serving: "Ingredient1", nutrition: ingredientNutrition)
    
    lazy var recipe1 = RecipeFinal(title: "Breakfast Meal 1", meal: .breakfast, ingredients: [ingredient, ingredient])
    lazy var recipe5 = RecipeFinal(title: "Breakfast Meal 2", meal: .breakfast, ingredients: [ingredient, ingredient])
    lazy var recipe2 = RecipeFinal(title: "Lunch Meal 1", meal: .lunch, ingredients: [ingredient, ingredient])
    lazy var recipe3 = RecipeFinal(title: "Dinner Meal 1", meal: .dinner,ingredients: [ingredient, ingredient])
    lazy var recipe4 = RecipeFinal(title: "Snack Meal 1", meal: .snack, ingredients: [ingredient, ingredient])
    
    lazy var recipes: [RecipeFinal] = [recipe1,recipe2,recipe3,recipe4,recipe5]
    
    // sample data
//    var ingredientNutrition = Nutrition(sugar: 1, fiber: 1, serving: 1, sodium: 1, name: "onion", potassium: 1, fat: 1, totalFat: 1, calories: 1, cholesterol: 1, protein: 1, carbohydrates: 1)
//    lazy var recipe1 = Recipe(title: "Breakfast Meal 1", ingredients: [(serving: "ingredient 1", nutrition: ingredientNutrition),
//                                                                                         (serving: "ingredient 2", nutrition: ingredientNutrition)])
//    lazy var recipe5 = Recipe(title: "Breakfast Meal 2", ingredients: [(serving: "ingredient 10", nutrition: ingredientNutrition)])
//    lazy var recipe2 = Recipe(title: "Lunch Meal 1", ingredients: [(serving: "ingredient 2", nutrition: ingredientNutrition)])
//    lazy var recipe3 = Recipe(title: "Dinner Meal 1", ingredients: [(serving: "ingredient 3", nutrition: ingredientNutrition)])
//    lazy var recipe4 = Recipe(title: "Snack Meal 1", ingredients: [(serving: "ingredient 4", nutrition: ingredientNutrition)])

//    lazy var breakfastMeals = RecipeList(category: .breakfast, recipes: [recipe1, recipe5])
//    lazy var lunchMeals = RecipeList(category: .lunch, recipes: [recipe2])
//    lazy var dinnerMeals = RecipeList(category: .dinner, recipes: [recipe3])
//    lazy var snackMeals = RecipeList(category: .snack, recipes: [recipe4])
//    lazy var catalog = Catalog(catalog: [breakfastMeals, lunchMeals, dinnerMeals, snackMeals])
    
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
//        return catalog.catalog.count
        // Reference -> https://stackoverflow.com/questions/27094878/how-do-i-get-the-count-of-a-swift-enum#:~:text=25%20Answers&text=Adopt%20the%20CaseIterable%20protocol%20in,many%20cases%20the%20enum%20has.
        return Meal.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
//        let meal = catalog.catalog[indexPath.row].category.rawValue
        
        let meal = recipes[indexPath.row].meal.rawValue
        cell.textLabel?.text = "\(meal)"
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 0.5
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let clickedMeal = MenuTotalCalorieDetailListViewController()
//        clickedMeal.mealTitle = catalog.catalog[indexPath.row].category.rawValue
        clickedMeal.mealTitle = recipes[indexPath.row].meal.rawValue
        // Reference -> https://stackoverflow.com/questions/28672836/how-to-get-a-value-of-selected-row-in-swift/42088775
        let selectedItem = indexPath
        clickedMeal.selectedCategory = selectedItem.row
        navigationController?.pushViewController(clickedMeal, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
}
