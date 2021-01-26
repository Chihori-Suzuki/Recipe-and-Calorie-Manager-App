//
//  MenuTotalCalorieDetailListViewController.swift
//  Recipe and Calorie Manager
//
//  Created by Kazunobu Someya on 2021-01-20.
//

import UIKit

class MenuTotalCalorieDetailListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SaveRecipeTableViewCellDelegate {
    func discardRecipe() {
        
    }
    
    
    func save(_ mealType: Meal, _ recipe: Recipe) {
        switch mealType {
        case .breakfast:
            breakfastMeals.recipes.insert(recipe, at: 0)
        case .lunch:
            lunchMeals.recipes.insert(recipe, at: 0)
        case .snack:
            snackMeals.recipes.insert(recipe, at: 0)
        case .dinner:
            dinnerMeals.recipes.insert(recipe, at: 0)
        }
        myTable.insertRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }
    
    var selectedCategory: Int?
    
    // sample data
    var ingredientNutrition = Nutrition(sugar: 1.0, fiber: 1, serving: 1, sodium: 1, name: "onion", potassium: 1, fat: 1, totalFat: 1, calories: 1.0, cholesterol: 1, protein: 1, carbohydrates: 1)
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = mealTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        myTable.allowsMultipleSelectionDuringEditing = true
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
        return catalog.catalog[selectCategory].recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MenuTotalCalorieDetailTableViewCell
            
        guard let selectCategory = selectedCategory else { return UITableViewCell()}
        let cellTitle = catalog.catalog[selectCategory].recipes[indexPath.row].title
        let cellTotalCalories = catalog.catalog[selectCategory].recipes[indexPath.row].ingredients.map { $0.nutrition!.calories }.reduce(0){ $0 + $1 }
        cell.update(cellTitle, cellTotalCalories)
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
//        let removedCell = catalog.catalog[selectedCategory].recipes.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let clickedMeal = AddIngredientsViewController()
        
        guard let selectedCategory = selectedCategory else { return }
        
        let selectedMeal = catalog.catalog[selectedCategory].recipes[indexPath.row]
        let mealType = catalog.catalog[selectedCategory].category
        clickedMeal.ingredients = selectedMeal.ingredients
        clickedMeal.recipeTitle = selectedMeal.title
        clickedMeal.isViewFromRecipeList = true
        clickedMeal.meal = mealType
//        var ingredients = [(serving: String, nutrition: Nutrition?)]() {
        navigationController?.pushViewController(clickedMeal, animated: true)
    }
}
