//
//  MenuTotalCalorieDetailListViewController.swift
//  Recipe and Calorie Manager
//
//  Created by Kazunobu Someya on 2021-01-20.
//

import UIKit

class MenuTotalCalorieDetailListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // meal category of selected row on RecipeListViewControleller
    var selectedCategory: Meal?
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
    
    
//    lazy var breakfastMeals = RecipeList(category: .breakfast, recipes: [recipe1, recipe5])
//    lazy var lunchMeals = RecipeList(category: .lunch, recipes: [recipe2])
//    lazy var dinnerMeals = RecipeList(category: .dinner, recipes: [recipe3])
//    lazy var snackMeals = RecipeList(category: .snack, recipes: [recipe4])
//    lazy var catalog = Catalog(catalog: [breakfastMeals, lunchMeals, dinnerMeals, snackMeals])
    
    // set large title on navigation bar
    var mealTitle: String?
    let cellId = "MenuTotalCalorie"
    
    lazy var myTable: UITableView = {
        let table = UITableView(frame: view.frame, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(MenuTotalCalorieDetailTableViewCell.self, forCellReuseIdentifier: cellId)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    lazy var doneBtn: UIBarButtonItem =  {
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneEditing))
        return done
    }()
    
    lazy var editBtn: UIBarButtonItem = {
        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTableViewCell))
        return edit
    }()
    
    // make variable to fill data from file
    var recipeList: [RecipeFinal] = []
    // make empty array to classify meal type after fetching data from file
    var breakfastMeals: [RecipeFinal] = []
    var lunchMeals: [RecipeFinal] = []
    var dinnerMeals: [RecipeFinal] = []
    var snackMeals: [RecipeFinal] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let recipeList = RecipeFinal.loadFromList() {
            self.recipeList = recipeList
            breakfastMeals = self.recipeList.filter {$0.meal == .breakfast}
            lunchMeals = self.recipeList.filter {$0.meal == .lunch}
            dinnerMeals = self.recipeList.filter {$0.meal == .dinner}
            snackMeals = self.recipeList.filter {$0.meal == .snack}
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = mealTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
//        myTable.allowsMultipleSelectionDuringEditing = true
        navigationItem.rightBarButtonItem = editBtn
    }
    
    @objc func editTableViewCell() {
        myTable.setEditing(true, animated: true)
        navigationItem.rightBarButtonItem = doneBtn
    }
    
    @objc func doneEditing() {
        myTable.setEditing(false, animated: true)
        navigationItem.rightBarButtonItem = editBtn
    }
    
    func setupTableView() {
        view.addSubview(myTable)
        myTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        myTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        myTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        myTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let selectCategory = selectedCategory else { return 0}
        // Reference -> https://www.hackingwithswift.com/example-code/language/how-to-count-matching-items-in-an-array
        switch selectCategory {
        case .breakfast:
            return breakfastMeals.count
        case .lunch:
            return lunchMeals.count
        case .dinner:
            return dinnerMeals.count
        case .snack:
            return snackMeals.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MenuTotalCalorieDetailTableViewCell
            
        guard let selectCategory = selectedCategory else { return UITableViewCell()}
        
        var cellTitle: String = ""
        var totalCalories: Double = 0.0
        
        switch selectCategory {
        case .breakfast:
            cellTitle = breakfastMeals[indexPath.row].title
            totalCalories = breakfastMeals[indexPath.row].ingredients.map { $0.nutrition.calories }.reduce(0) { $0 + $1 }
        case .lunch:
            cellTitle = lunchMeals[indexPath.row].title
            totalCalories = lunchMeals[indexPath.row].ingredients.map { $0.nutrition.calories }.reduce(0) { $0 + $1 }
        case .dinner:
            cellTitle = dinnerMeals[indexPath.row].title
            totalCalories = dinnerMeals[indexPath.row].ingredients.map { $0.nutrition.calories }.reduce(0) { $0 + $1 }
        case .snack:
            cellTitle = snackMeals[indexPath.row].title
            totalCalories = snackMeals[indexPath.row].ingredients.map { $0.nutrition.calories }.reduce(0) { $0 + $1 }
        }
        cell.update(cellTitle, totalCalories)
//        cell.accessoryType = .detailDisclosureButton
        cell.showsReorderControl = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true 
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let selectCategory = selectedCategory else { return }
//            let cellTitle = catalog.catalog[selectCategory].recipes[indexPath.row].title
//            let cellTotalCalories = catalog.catalog[selectCategory].recipes[indexPath.row].ingredients.map { $0.nutrition!.calories }.reduce(0){ $0 + $1 }
//            catalog.catalog.remove(at: 0)
            let indexPath = IndexPath(item: 0, section: 0)
            myTable.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let clickedMeal = AddIngredientsViewController()
        guard let selectedCategory = selectedCategory else { return }
        
        var recipe: RecipeFinal!
        
        switch selectedCategory {
        case .breakfast:
            recipe = breakfastMeals[indexPath.row]
        case .lunch:
            recipe = lunchMeals[indexPath.row]
        case .dinner:
            recipe = dinnerMeals[indexPath.row]
        case .snack:
            recipe = snackMeals[indexPath.row]
        }
        
        
        // pass data to variable of instance clickedMeal should be in the following order
        clickedMeal.recipeTitle = recipe.title
        clickedMeal.meal = selectedCategory
        clickedMeal.ingredients = recipe.ingredients
        clickedMeal.isViewFromRecipeList = true
        navigationController?.pushViewController(clickedMeal, animated: true)
    }
}
