//
//  AddIngredientsViewController.swift
//  Recipe and Calorie Manager
//
//  Created by Gil Jetomo on 2021-01-19.
//

import UIKit

class AddIngredientsViewController: UIViewController, EditIngredientVCDelegate, SaveRecipeTableViewCellDelegate {
    //SaveRecipeTableViewCellDelegate function
    func save() -> Bool {
        guard let newRecipe = recipe else { return true }
        if let _ = Recipe.loadFromDraft() { Recipe.deleteDraft() }
        
        let duplicateRecipe = recipes.filter {$0 == recipe}
        guard duplicateRecipe.count == 0 else { return true }
        
        if let recipeFromList = recipeFromList {
            recipes = recipes.filter {$0 != recipeFromList}
        }
        recipes.append(newRecipe)
        Recipe.saveToList(recipes: recipes)
        
        if let tabItem = tabBarController?.tabBar.items {
            Recipe.newRecipeCount += 1
            tabItem[0].badgeValue = String(Recipe.newRecipeCount)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.navigationController?.popViewController(animated: true)
        }
        return false
    }
    //SaveRecipeTableViewCellDelegate function
    func discardRecipe() {
        if let _ = Recipe.loadFromDraft() {
            Recipe.deleteDraft()
        }
        if let recipeFromList = recipeFromList {
            recipes = recipes.filter {$0 != recipeFromList}
            Recipe.saveToList(recipes: recipes)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 1) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    //EditIngredientVCDelegate function
    func edit(_ ingredient: Ingredient) {
        guard let indexPath = selectedRowForEdit else { return }
        ingredients.remove(at: indexPath.row)
        ingredients.insert(Ingredient(serving: ingredient.serving, nutrition: ingredient.nutrition), at: indexPath.row)
        tableview.reloadRows(at: [indexPath], with: .automatic)
        tableview.reloadSections([1, 2], with: .none)
    }
    //EditIngredientVCDelegate function
    func delete(_ ingredient: Ingredient) {
        guard let indexPath = selectedRowForEdit else { return }
        let currentIngredient = ingredients[indexPath.row]
        if currentIngredient == ingredient {
            ingredients.remove(at: indexPath.row)
            tableview.deleteRows(at: [indexPath], with: .automatic)
            tableview.reloadSections([1, 2], with: .none)
        }
    }
    var recipe: Recipe? {
        didSet {
            Recipe.saveToDraft(recipe: recipe!)
        }
    }
    var selectedRowForEdit: IndexPath?
    var recipes: [Recipe] = []
    var duplicateFound = false
    var isViewFromRecipeList: Bool?
    var recipeFromList: Recipe?
    var meal: Meal?
    var recipeTitle: String?
    var ingredients = [Ingredient]() {
        didSet {
            recipe = Recipe(title: recipeTitle!, meal: meal!, ingredients: ingredients)
            guard let _ = isViewFromRecipeList else {
                ingredients.count == 0 ? (navigationItem.rightBarButtonItem?.isEnabled = true) : (navigationItem.rightBarButtonItem?.isEnabled = false)
                return
            }
        }
    }
    var caloriesTotal: Double? {
        didSet { caloriesTotalCountLabel.count(from: Float(oldValue ?? 0), to: Float(caloriesTotal ?? 0), duration: .brisk) }
    }
    var carbsTotal: Double? {
        didSet { carbsTotalCountLabel.count(from: Float(oldValue ?? 0), to: Float(carbsTotal ?? 0), duration: .brisk) }
    }
    var proteinTotal: Double? {
        didSet { proteinTotalCountLabel.count(from: Float(oldValue ?? 0), to: Float(proteinTotal ?? 0), duration: .brisk) }
    }
    var fatTotal: Double? {
        didSet { fatTotalCountLabel.count(from: Float(oldValue ?? 0), to: Float(fatTotal ?? 0), duration: .brisk) }
    }
    var fiberTotal: Double? {
        didSet { fiberTotalCountLabel.count(from: Float(oldValue ?? 0), to: Float(fiberTotal ?? 0), duration: .brisk) }
    }
    let sectionTitles = ["Ingredients", "Nutrition Facts", ""]
    var tableview = UITableView()
    var totalsStackViews = UIStackView()
    var caloriesTotalCountLabel = AnimatedLabelTotalsCal()
    var carbsTotalCountLabel = AnimatedLabelTotals()
    var proteinTotalCountLabel = AnimatedLabelTotals()
    var fatTotalCountLabel = AnimatedLabelTotals()
    var fiberTotalCountLabel = AnimatedLabelTotals()
    let ingredientTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "1 tbsp canola oil"
        tf.font = .systemFont(ofSize: 25)
        tf.widthAnchor.constraint(equalToConstant: 270).isActive = true
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tf.becomeFirstResponder()
        tf.layer.borderWidth = 0.8
        tf.layer.borderColor = UIColor.Theme1.black.cgColor
        tf.textColor = UIColor.Theme1.brown
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 8
        tf.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    let addButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.contentMode = .scaleAspectFit
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(addNewIngredient), for: .touchUpInside)
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    let hStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 15
        return sv
    }()
    let vStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 10
        sv.backgroundColor = UIColor.Theme1.white
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let addLabel: UILabel = {
        let label = UILabel()
        label.text = "add"
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        label.textAlignment = .center
        label.textColor = UIColor.Theme1.brown
        label.alpha = 0.8
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    func makeLabelTotals(with string: String) -> UILabel {
        let label = UILabel()
        label.text = string
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.alpha = 0.8
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor.Theme1.green
        label.textColor = .white
        label.layer.cornerRadius = 6
        return label
    }
    func makeLabelTotals() -> AnimatedLabelTotals {
        let label = AnimatedLabelTotals()
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.decimalPoints = .two
        label.textColor = UIColor.Theme1.black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }
    func makeLabelTotalsCal() -> AnimatedLabelTotalsCal {
        let label = AnimatedLabelTotalsCal()
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.decimalPoints = .two
        label.textColor = UIColor.Theme1.black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }
    func makeTotalsStackView(with labels: [(UIView, UIView)]) -> UIStackView {
        let hStackView = UIStackView()
        for view in labels {
            let (header, total) = view
            let vStackView = UIStackView(arrangedSubviews: [header, total])
            vStackView.axis = .vertical
            vStackView.alignment = .center
            vStackView.distribution = .fillEqually
            vStackView.spacing = 5
            vStackView.widthAnchor.constraint(equalToConstant: 70).isActive = true
            hStackView.addArrangedSubview(vStackView)
        }
        hStackView.axis = .horizontal
        hStackView.alignment = .center
        hStackView.distribution = .equalCentering
        hStackView.spacing = 5
        
        hStackView.isHidden = true
        
        if let _ = isViewFromRecipeList { hStackView.isHidden = false }
        if let _ = recipe { hStackView.isHidden = false }
        
        return hStackView
    }
    fileprivate func setupStackViews() {
        //title labels, let is used as the 'headers' are constant
        let caloriesTotalLabel = makeLabelTotals(with: "Calories")
        let carbsTotalLabel = makeLabelTotals(with: "Carbs")
        let proteinTotalLabel = makeLabelTotals(with: "Protein")
        let fatTotalLabel = makeLabelTotals(with: "Fat")
        let fiberTotalLabel = makeLabelTotals(with: "Fiber")
        //total labels are declared as variable so that their text property can be updated and animated
        caloriesTotalCountLabel = makeLabelTotalsCal()
        caloriesTotalCountLabel.textColor = UIColor.Theme1.black
        carbsTotalCountLabel = makeLabelTotals()
        proteinTotalCountLabel = makeLabelTotals()
        fatTotalCountLabel = makeLabelTotals()
        fiberTotalCountLabel = makeLabelTotals()
        //title and total labels are added in a tuple so that they can be properly arranged in a stackview
        let totalLabels: [(UIView, UIView)] = [(caloriesTotalLabel, caloriesTotalCountLabel),
                                               (carbsTotalLabel, carbsTotalCountLabel),
                                               (proteinTotalLabel, proteinTotalCountLabel),
                                               (fatTotalLabel, fatTotalCountLabel),
                                               (fiberTotalLabel, fiberTotalCountLabel)]
        
        totalsStackViews = makeTotalsStackView(with: totalLabels)
        
        let vSV = UIStackView(arrangedSubviews: [addButton, addLabel])
        vSV.axis = .vertical
        vSV.alignment = .center
        vSV.distribution = .fill
        vSV.spacing = 0
        
        hStackView.addArrangedSubview(ingredientTextField)
        hStackView.addArrangedSubview(vSV)
        
        vStackView.addArrangedSubview(hStackView)
        vStackView.addArrangedSubview(totalsStackViews)
        vStackView.addArrangedSubview(UIView())
        
        view.addSubview(vStackView)
        
        vStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        vStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        vStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
    }
    override func viewWillAppear(_ animated: Bool) {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Theme1.orange, NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 30)!]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.Theme1.blue
        
        if let savedList = Recipe.loadFromList() {
            recipes = savedList
        }
        guard let recipe = recipe else { return }
        caloriesTotalCountLabel.text = String(format: "%.2f", recipe.ingredients.map { $0.nutrition.calories }.reduce(0){ $0 + $1 })
        carbsTotalCountLabel.text = String(format: "%.2f g", recipe.ingredients.map { $0.nutrition.carbohydrates }.reduce(0){ $0 + $1 })
        proteinTotalCountLabel.text = String(format: "%.2f g", recipe.ingredients.map { $0.nutrition.protein }.reduce(0){ $0 + $1 })
        fatTotalCountLabel.text = String(format: "%.2f g", recipe.ingredients.map { $0.nutrition.totalFat }.reduce(0){ $0 + $1 })
        fiberTotalCountLabel.text = String(format: "%.2f g", recipe.ingredients.map { $0.nutrition.fiber }.reduce(0){ $0 + $1 })
    }
    @objc func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
        if let _ = Recipe.loadFromDraft() { Recipe.deleteDraft() }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let meal = meal?.rawValue {
            addButton.setImage(UIImage(named: meal), for: .normal)
        }
        view.backgroundColor = UIColor.Theme1.white
        navigationItem.hidesBackButton = true
        title = recipeTitle
        setupStackViews()
        setupTableView()
    }
    @objc func addNewIngredient() {
        UIView.animate(withDuration: 0.10) {
            self.addButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        } completion: { (_) in
            UIView.animate(withDuration: 0.10) {
                self.addButton.transform = CGAffineTransform.identity
            }
        }
        let serving = ingredientTextField.text!
        NutritionAPI.shared.fetchNutritionInfo(query: serving) { (result) in
            switch result {
            case .success(let ingredient):
                self.updateTableView(with: serving, and: ingredient)
            case .failure(let error):
                print(error)
            }
        }
        self.ingredientTextField.text?.removeAll()
    }
    fileprivate func calculateTotals() {
        caloriesTotal = ingredients.map { $0.nutrition.calories }.reduce(0){ $0 + $1 }
        carbsTotal = ingredients.map { $0.nutrition.carbohydrates }.reduce(0){ $0 + $1}
        proteinTotal = ingredients.map { $0.nutrition.protein }.reduce(0){ $0 + $1 }
        fatTotal = ingredients.map { $0.nutrition.totalFat }.reduce(0){ $0 + $1 }
        fiberTotal = ingredients.map { $0.nutrition.fiber }.reduce(0){ $0 + $1}
    }
    fileprivate func updateTableView(with serving: String, and ingredient: Dataset) {
        DispatchQueue.main.async { [self] in
            if ingredient.items.count > 0 {
                ingredients.insert(Ingredient(serving: serving, nutrition: ingredient.items[0]), at: 0)
                UIView.animate(withDuration: 0.9) {
                    totalsStackViews.isHidden ? totalsStackViews.isHidden.toggle() : nil
                    tableview.isHidden ? tableview.isHidden.toggle() : nil
                    tableview.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .top)
                    tableview.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
                calculateTotals()
                tableview.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .none)
            } else {
                //addButton vibrates to indicate invalid ingredient
                let animation = CABasicAnimation(keyPath: "position")
                animation.duration = 0.05
                animation.repeatCount = 4
                animation.autoreverses = true
                animation.fromValue = NSValue(cgPoint: CGPoint(x: addButton.center.x - 12, y: addButton.center.y))
                animation.toValue = NSValue(cgPoint: CGPoint(x: addButton.center.x + 12, y: addButton.center.y))
                addButton.layer.add(animation, forKey: "position")
            }
        }
    }
    @objc func textEditingChanged(_ sender: UITextField) {
        guard let text = sender.text, text.count > 4 else {
            addButton.alpha = 0.5
            addButton.isEnabled = false
            return
        }
        addButton.alpha = 1.0
        addButton.isEnabled = true
    }
    fileprivate func setupTableView() {
        tableview = UITableView(frame: view.frame, style: .insetGrouped)
        tableview.backgroundColor = UIColor.Theme1.white
        view.addSubview(tableview)
        
        tableview.register(IngredientTableViewCell.self, forCellReuseIdentifier: IngredientTableViewCell.identifier)
        tableview.register(NutritionFactsTableViewCell.self, forCellReuseIdentifier: NutritionFactsTableViewCell.identifier)
        tableview.register(SaveRecipeTableViewCell.self, forCellReuseIdentifier: SaveRecipeTableViewCell.identifier)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.topAnchor.constraint(equalTo: vStackView.bottomAnchor, constant: 0).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        
        tableview.isHidden = true
        
        if let _ = isViewFromRecipeList { tableview.isHidden = false }
        if let _ = recipe { tableview.isHidden = false }
    }
}
extension AddIngredientsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch  section {
        case 0:
            return ingredients.count
        case 1...2:
            return 1
        default:
            fatalError()
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let ingredient = ingredients[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientTableViewCell.identifier, for: indexPath) as! IngredientTableViewCell
            cell.update(with: ingredient)
            cell.layer.borderColor = UIColor.Theme1.black.cgColor
            cell.layer.borderWidth = 0.5
            cell.accessoryType = .detailButton
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionFactsTableViewCell.identifier, for: indexPath) as! NutritionFactsTableViewCell
            cell.update(with: ingredients)
            cell.backgroundColor = UIColor.Theme1.white
            cell.isUserInteractionEnabled = false
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: SaveRecipeTableViewCell.identifier, for: indexPath) as! SaveRecipeTableViewCell
            cell.delegate = self
            cell.mealType = meal
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                if self.ingredients.count > 0 {
                    cell.saveButton.isHidden = false
                    cell.discardButton.isHidden = false
                } else {
                    cell.saveButton.isHidden = true
                    cell.discardButton.isHidden = true
                }
            }
            cell.selectionStyle = .none
            return cell
        default:
            fatalError()
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: .zero, y: .zero, width: tableView.frame.width, height: 35)
        myLabel.font = UIFont.boldSystemFont(ofSize: 22)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        myLabel.textColor = UIColor.Theme1.brown
        myLabel.layer.cornerRadius = 12
        
        let headerView = UIView()
        headerView.addSubview(myLabel)
        myLabel.contentMode = .scaleAspectFit
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let selectedIngredient = Ingredient(serving: ingredients[indexPath.row].serving, nutrition: ingredients[indexPath.row].nutrition)
        selectedRowForEdit = indexPath
        let editVC = EditIngredientViewController()
        editVC.meal = meal
        editVC.delegate = self
        editVC.ingredient = selectedIngredient
        present(editVC, animated: true, completion: nil)
    }
    //function needed to enable swipe delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [self] in
            ingredients.remove(at: indexPath.row)
            tableview.deleteRows(at: [indexPath], with: .left)
            calculateTotals()
            tableview.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .none)
        }
    }
    //function needed to enable swipe delete
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case 0: return true
        default: return false
        }
    }
}
