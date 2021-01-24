//
//  AddIngredientsViewController.swift
//  Recipe and Calorie Manager
//
//  Created by Gil Jetomo on 2021-01-19.
//

import UIKit

class AddIngredientsViewController: UIViewController, EditIngredientVCDelegate {
    
    var selectedRowForEdit: IndexPath?
    
    func edit(_ ingredient: Ingredient) {
        guard let indexPath = selectedRowForEdit else { return }
        ingredients.remove(at: indexPath.row)
        ingredients.insert((serving: ingredient.serving, nutrition: ingredient.nutrition), at: indexPath.row)
        tableview.reloadRows(at: [indexPath], with: .automatic)
    }
    
    let sectionTitles = ["Ingredients", "Nutrition Facts", ""]
    var tableview = UITableView()
    var totalsStackViews = UIStackView()
    var caloriesTotalCountLabel = AnimatedLabelTotalsCal()
    var carbsTotalCountLabel = AnimatedLabelTotals()
    var proteinTotalCountLabel = AnimatedLabelTotals()
    var fatTotalCountLabel = AnimatedLabelTotals()
    var fiberTotalCountLabel = AnimatedLabelTotals()
    var meal: Meal?
    var recipeTitle: String?
    var ingredients = [(serving: String, nutrition: Nutrition?)]()

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
    
    let ingredientTextField: UITextField = {
       let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "1 tbsp canola oil"
        tf.font = .systemFont(ofSize: 25)
        tf.widthAnchor.constraint(equalToConstant: 270).isActive = true
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tf.becomeFirstResponder()
        tf.layer.borderWidth = 0.8
        tf.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.layer.cornerRadius = 8
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    let addButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(addNewIngredient), for: .touchUpInside)
        button.isEnabled = false
        button.alpha = 0.5
    return button
    }()
    
    let hStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
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
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let addLabel: UILabel = {
        let label = UILabel()
        label.text = "add"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.4527973475, green: 0.2011018268, blue: 0.03813635361, alpha: 1)
        label.alpha = 0.8
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    func makeLabelTotals(with string: String) -> UILabel {
        let label = UILabel()
        label.text = string
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.alpha = 0.8
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.layer.masksToBounds = true
        label.backgroundColor = #colorLiteral(red: 0.7829411976, green: 0.9072662751, blue: 1, alpha: 1)
        label.layer.cornerRadius = 6
        return label
    }
    
    func makeLabelTotals() -> AnimatedLabelTotals {
        let label = AnimatedLabelTotals()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.decimalPoints = .two
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }
    
    func makeLabelTotalsCal() -> AnimatedLabelTotalsCal {
        let label = AnimatedLabelTotalsCal()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.decimalPoints = .two
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }
    
    func makeTotalsStackView(with labels: [(UIView, UIView)]) -> UIStackView {
        let hStackView = UIStackView()
        for view in labels {
            let (header, total) = view
            let vStackView = UIStackView(arrangedSubviews: [header, total])
            vStackView.axis = .vertical
            vStackView.translatesAutoresizingMaskIntoConstraints = false
            vStackView.alignment = .center
            vStackView.distribution = .fillEqually
            vStackView.spacing = 5
            vStackView.widthAnchor.constraint(equalToConstant: 70).isActive = true
            hStackView.addArrangedSubview(vStackView)
        }
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        hStackView.alignment = .center
        hStackView.distribution = .equalCentering
        hStackView.spacing = 5
        hStackView.isHidden = true
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
        
        view.addSubview(vStackView)
        
        vStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let meal = meal?.rawValue {
            addButton.setImage(UIImage(named: meal), for: .normal)
        }
    
        view.backgroundColor = .white
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
    }
    
    fileprivate func calculateTotals() {
        caloriesTotal = ingredients.map { $0.nutrition!.calories }.reduce(0){ $0 + $1 }
        carbsTotal = ingredients.map { $0.nutrition!.carbohydrates }.reduce(0){ $0 + $1}
        proteinTotal = ingredients.map { $0.nutrition!.protein }.reduce(0){ $0 + $1 }
        fatTotal = ingredients.map { $0.nutrition!.totalFat }.reduce(0){ $0 + $1 }
        fiberTotal = ingredients.map { $0.nutrition!.fiber }.reduce(0){ $0 + $1}
    }
    
    fileprivate func updateTableView(with serving: String, and ingredient: Dataset) {
        DispatchQueue.main.async { [self] in
            if ingredient.items.count > 0 {
            
                ingredients.insert((serving: serving, nutrition: ingredient.items[0]), at: 0)
                UIView.animate(withDuration: 0.9) {
                    totalsStackViews.isHidden ? totalsStackViews.isHidden.toggle() : nil
                    tableview.isHidden ? tableview.isHidden.toggle() : nil
                    tableview.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .top)
                    tableview.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                
                }
                calculateTotals()
                //need to reload the section of saveRecipe button to pass the updated contents of ingredients
                UIView.animate(withDuration: 0.5, animations: {
                    tableview.reloadSections([1, 2], with: .none)
                tableview.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .none)
                })
            

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
        tableview.backgroundColor = .white
        view.addSubview(tableview)
        
        tableview.register(IngredientTableViewCell.self, forCellReuseIdentifier: IngredientTableViewCell.identifier)
        tableview.register(NutritionFactsTableViewCell.self, forCellReuseIdentifier: NutritionFactsTableViewCell.identifier)
        tableview.register(SaveRecipeTableViewCell.self, forCellReuseIdentifier: SaveRecipeTableViewCell.identifier)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.topAnchor.constraint(equalTo: vStackView.bottomAnchor, constant: 12).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        tableview.isHidden = true
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
            cell.layer.borderColor = UIColor.gray.cgColor
            cell.layer.borderWidth = 0.5
            cell.accessoryType = .detailButton
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionFactsTableViewCell.identifier, for: indexPath) as! NutritionFactsTableViewCell
            
            let totalFat = ingredients.map { $0.nutrition!.totalFat }.reduce(0){ $0 + $1 }
            cell.totalFatLabel.text = String(format: "%.2f g", totalFat)
            cell.totalFatDV.text = (String(format: "%.2f", (totalFat/DailyValue.totalFat.rawValue)*100)+" %")
            
            let totalCholesterol = ingredients.map { $0.nutrition!.cholesterol }.reduce(0){ $0 + $1 }
            cell.totalCholesterolLabel.text = String(format: "%.2f g", totalCholesterol)
            cell.totalCholesterolDV.text = (String(format: "%.2f", (totalFat/DailyValue.cholesterol.rawValue)*100)+" %")
            
            let totalSodium = ingredients.map { $0.nutrition!.sodium }.reduce(0){ $0 + $1 }
            cell.totalSodiumLabel.text = String(format: "%.2f g", totalSodium)
            cell.totalSodiumDV.text = (String(format: "%.2f", (totalFat/DailyValue.sodium.rawValue)*100)+" %")
            
            let totalCarbs = ingredients.map { $0.nutrition!.carbohydrates }.reduce(0){ $0 + $1 }
            cell.totalCarbsLabel.text = String(format: "%.2f g", totalCarbs)
            cell.totalCarbsDV.text = (String(format: "%.2f", (totalFat/DailyValue.totalCarbs.rawValue)*100)+" %")
            
            let totalProtein = ingredients.map { $0.nutrition!.protein }.reduce(0){ $0 + $1 }
            cell.totalProteinLabel.text = String(format: "%.2f g", totalProtein)
            cell.totalProteinDV.text = (String(format: "%.2f", (totalFat/DailyValue.protein.rawValue)*100)+" %")

            let totalPotassium = ingredients.map { $0.nutrition!.potassium }.reduce(0){ $0 + $1 }
            cell.totalPotassiumLabel.text = String(format: "%.2f g", totalPotassium)
            cell.totalPotassiumDV.text = (String(format: "%.2f", (totalFat/DailyValue.potassium.rawValue)*100)+" %")
            
            let totalSatFat = ingredients.map { $0.nutrition!.fat }.reduce(0){ $0 + $1 }
            cell.totalSatFatLabel.text = String(format: "%.2f g", totalSatFat)
            cell.totalSatFatDV.text = (String(format: "%.2f", (totalFat/DailyValue.satFat.rawValue)*100)+" %")
            
            cell.totalCaloriesLabel.text = String(format: "%.2f", ingredients.map { $0.nutrition!.calories }.reduce(0){ $0 + $1 })
            cell.isUserInteractionEnabled = false
            
            cell.totalFiberLabel.text = String(format: "%.2f g", ingredients.map { $0.nutrition!.fiber }.reduce(0){ $0 + $1 })
            cell.totalSugarLabel.text = String(format: "%.2f g", ingredients.map { $0.nutrition!.sugar }.reduce(0){ $0 + $1 })


            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: SaveRecipeTableViewCell.identifier, for: indexPath) as! SaveRecipeTableViewCell
            cell.mealType = meal
            cell.newRecipe = Recipe(title: recipeTitle!, ingredients: ingredients)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.ingredients.count > 1 ? (cell.saveButton.isHidden ? cell.saveButton.isHidden.toggle() : nil) : (cell.saveButton.isHidden = true)
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

        let headerView = UIView()
        headerView.addSubview(myLabel)

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
        let selectedIngredient = Ingredient(serving: ingredients[indexPath.row].serving, nutrition: ingredients[indexPath.row].nutrition!)
        selectedRowForEdit = indexPath
        let editVC = EditIngredientViewController()
        editVC.meal = meal
        editVC.delegate = self
        editVC.ingredient = selectedIngredient
        present(editVC, animated: true, completion: nil)
    }
    //function needed to enable swipe delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.ingredients.remove(at: indexPath.row)
            self.tableview.deleteRows(at: [indexPath], with: .left)
            self.calculateTotals()
            //need to reload the section of saveRecipe button to pass the updated contents of ingredients
            self.tableview.reloadSections([1, 2], with: .none)
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
