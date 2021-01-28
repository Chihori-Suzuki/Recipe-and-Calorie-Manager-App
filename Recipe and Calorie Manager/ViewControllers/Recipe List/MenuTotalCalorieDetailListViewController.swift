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
    // set large title on navigation bar
    var mealTitle: String?
    // make variable to fill data from file
    var recipeList: [Recipe] = []
    // make empty array to classify meal type after fetching data from file
    var breakfastMeals: [Recipe] = []
    var lunchMeals: [Recipe] = []
    var dinnerMeals: [Recipe] = []
    var snackMeals: [Recipe] = []
    
    lazy var doneBtn: UIBarButtonItem =  {
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneEditing))
        return done
    }()
    
    lazy var editBtn: UIBarButtonItem = {
        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTableViewCell))
        return edit
    }()
    
    lazy var myTable: UITableView = {
        let table = UITableView(frame: view.frame, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(MenuTotalCalorieDetailTableViewCell.self, forCellReuseIdentifier: MenuTotalCalorieDetailTableViewCell.identifier)
        table.backgroundColor = UIColor.Theme1.white
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let recipeList = Recipe.loadFromList() {
            self.recipeList = recipeList
            breakfastMeals = self.recipeList.filter {$0.meal == .breakfast}
            lunchMeals = self.recipeList.filter {$0.meal == .lunch}
            dinnerMeals = self.recipeList.filter {$0.meal == .dinner}
            snackMeals = self.recipeList.filter {$0.meal == .snack}
            
            let meals = recipeList.filter { $0.meal == selectedCategory }
            meals.count > 0 ? (navigationItem.rightBarButtonItem = editBtn) : ( navigationItem.rightBarButtonItem = nil)
            //need to refresh the table if user added a new recipe
            myTable.reloadData()
        }
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Theme1.yellow, NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 35)!]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Theme1.white
        title = mealTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        navigationController?.navigationBar.tintColor = UIColor.Theme1.blue
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
        myTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        myTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        myTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        myTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let selectCategory = selectedCategory else { return 0 }
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTotalCalorieDetailTableViewCell.identifier, for: indexPath) as! MenuTotalCalorieDetailTableViewCell
        
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
        
        cell.backgroundColor = UIColor.Theme1.white
        let chevronImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        chevronImageView.image = UIImage(named: "right-chevron")
        chevronImageView.image = chevronImageView.image?.withRenderingMode(.alwaysTemplate)
        chevronImageView.tintColor = UIColor.Theme1.green
        cell.accessoryView = chevronImageView
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let selectedCategory = selectedCategory else { return }
            
            var recipe: Recipe!
            switch selectedCategory {
            case .breakfast:
                recipe = breakfastMeals[indexPath.row]
                breakfastMeals = breakfastMeals.filter { $0 != recipe}
            case .lunch:
                recipe = lunchMeals[indexPath.row]
                lunchMeals = lunchMeals.filter {$0 != recipe}
            case .dinner:
                recipe = dinnerMeals[indexPath.row]
                dinnerMeals = dinnerMeals.filter {$0 != recipe}
            case .snack:
                recipe = snackMeals[indexPath.row]
                snackMeals = snackMeals.filter {$0 != recipe}
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [self] in
                myTable.deleteRows(at: [indexPath], with: .left)
            }
            // update recipeList
            recipeList = recipeList.filter {$0 != recipe}
            // save recipeList to file
            Recipe.saveToList(recipes: recipeList)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selectedCategory = selectedCategory else { return }
        
        var recipe: Recipe!
        
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
        let clickedMeal = AddIngredientsViewController()
        clickedMeal.recipeTitle = recipe.title
        clickedMeal.meal = selectedCategory
        clickedMeal.ingredients = recipe.ingredients
        clickedMeal.isViewFromRecipeList = true
        clickedMeal.recipe = recipe
        clickedMeal.recipeFromList = recipe
        
        navigationController?.pushViewController(clickedMeal, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
