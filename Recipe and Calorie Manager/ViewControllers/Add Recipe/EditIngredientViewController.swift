//
//  EditIngredientViewController.swift
//  Recipe and Calorie Manager
//
//  Created by Macbook Pro on 2021-01-23.
//

import UIKit

protocol EditIngredientVCDelegate: class {
    func edit(_ ingredient: Ingredient)
    func delete(_ ingredient: Ingredient)
}

class EditIngredientViewController: UIViewController, saveIngredientButtonTapped {
    
    func saveButtonTapped() {
        delegate?.edit(ingredient!)
        dismiss(animated: true, completion: nil)
    }
    
    func discardButtonTapped() {
        delegate?.delete(ingredient!)
        dismiss(animated: true, completion: nil)
    }
    
    var meal: Meal?
    var ingredient: Ingredient?
    weak var delegate: EditIngredientVCDelegate?
    
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
        tf.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    let updateButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 8
        button.isEnabled = true
        button.addTarget(self, action: #selector(updateIngredient), for: .touchUpInside)
        button.alpha = 0.5
    return button
    }()
    
    let updateLabel: UILabel = {
        let label = UILabel()
        label.text = "update"
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.4527973475, green: 0.2011018268, blue: 0.03813635361, alpha: 1)
        label.alpha = 0.8
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var vStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [updateButton, updateLabel])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 0
        return sv
    }()
    
    lazy var hStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [ingredientTextField, vStackView])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 15
        return sv
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: view.frame, style: .insetGrouped)
        tv.backgroundColor = UIColor.Theme1.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Theme1.white
        
        ingredientTextField.text = ingredient?.serving
        if let meal = meal?.rawValue {
            updateButton.setImage(UIImage(named: meal), for: .normal)
        }
        view.addSubview(hStackView)
        hStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        hStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        view.addSubview(tableView)
        tableView.register(NutritionFactsTableViewCell.self, forCellReuseIdentifier: NutritionFactsTableViewCell.identifier)
        tableView.register(SaveIngredientTableViewCell.self, forCellReuseIdentifier: SaveIngredientTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: hStackView.bottomAnchor, constant: 12).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    @objc func updateIngredient(_ sender: UIButton) {
        UIView.animate(withDuration: 0.10) {
            self.updateButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        } completion: { (_) in
            UIView.animate(withDuration: 0.10) {
                self.updateButton.transform = CGAffineTransform.identity
            }
        }
        let serving = ingredientTextField.text!
        NutritionAPI.shared.fetchNutritionInfo(query: serving) { (result) in
            switch result {
            case .success(let newIngredient):
                self.updateNutritionFacts(with: serving, and: newIngredient)
            case .failure(let error):
                print(error)
            }
        }
    }
    fileprivate func updateNutritionFacts(with serving: String, and newIngredient: Dataset) {
        DispatchQueue.main.async { [self] in
            if newIngredient.items.count > 0 {
                    ingredient = Ingredient(serving: serving, nutrition: newIngredient.items[0])
                    tableView.reloadSections([0,1], with: .none)
                UIView.animate(withDuration: 1) {
                    tableView.isHidden = false
                }
            } else {
                ingredient = nil
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    UIView.animate(withDuration: 5, delay: 0, options: .curveEaseOut) {
                        tableView.isHidden = true
                    }
                }
                //addButton vibrates to indicate invalid ingredient
                let animation = CABasicAnimation(keyPath: "position")
                animation.duration = 0.05
                animation.repeatCount = 4
                animation.autoreverses = true
                animation.fromValue = NSValue(cgPoint: CGPoint(x: updateButton.center.x - 12, y: updateButton.center.y))
                animation.toValue = NSValue(cgPoint: CGPoint(x: updateButton.center.x + 12, y: updateButton.center.y))
                updateButton.layer.add(animation, forKey: "position")
            }
        }
    }
    @objc func textEditingChanged(_ sender: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.tableView.isHidden = true
            
            guard let text = sender.text, text.count > 4 else {
                self.updateButton.alpha = 0.5
                self.updateButton.isEnabled = false
                return
            }
            self.updateButton.alpha = 1.0
            self.updateButton.isEnabled = true
        }
    }
}

extension EditIngredientViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let ingredient = ingredient else { return UITableViewCell() }
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionFactsTableViewCell.identifier, for: indexPath) as! NutritionFactsTableViewCell
            
            let totalFat = ingredient.nutrition.totalFat
            cell.totalFatLabel.text = String(format: "%.2f g", totalFat)
            cell.totalFatDV.text = (String(format: "%.2f", (totalFat/DailyValue.totalFat.rawValue)*100)+" %")
            
            let totalCholesterol = ingredient.nutrition.cholesterol
            cell.totalCholesterolLabel.text = String(format: "%.2f g", totalCholesterol)
            cell.totalCholesterolDV.text = (String(format: "%.2f", (totalFat/DailyValue.cholesterol.rawValue)*100)+" %")
            
            let totalSodium = ingredient.nutrition.sodium
            cell.totalSodiumLabel.text = String(format: "%.2f g", totalSodium)
            cell.totalSodiumDV.text = (String(format: "%.2f", (totalSodium/DailyValue.sodium.rawValue)*100)+" %")
            
            let totalCarbs = ingredient.nutrition.carbohydrates
            cell.totalCarbsLabel.text = String(format: "%.2f g", totalCarbs)
            cell.totalCarbsDV.text = (String(format: "%.2f", (totalCarbs/DailyValue.totalCarbs.rawValue)*100)+" %")
            
            let totalProtein = ingredient.nutrition.protein
            cell.totalProteinLabel.text = String(format: "%.2f g", totalProtein)
            cell.totalProteinDV.text = (String(format: "%.2f", (totalProtein/DailyValue.protein.rawValue)*100)+" %")

            let totalPotassium = ingredient.nutrition.potassium
            cell.totalPotassiumLabel.text = String(format: "%.2f g", totalPotassium)
            cell.totalPotassiumDV.text = (String(format: "%.2f", (totalPotassium/DailyValue.potassium.rawValue)*100)+" %")
            
            let totalSatFat = ingredient.nutrition.fat
            cell.totalSatFatLabel.text = String(format: "%.2f g", totalSatFat)
            cell.totalSatFatDV.text = (String(format: "%.2f", (totalSatFat/DailyValue.satFat.rawValue)*100)+" %")
            
            cell.totalCaloriesLabel.text = String(format: "%.2f", ingredient.nutrition.calories)
            cell.isUserInteractionEnabled = false
            cell.backgroundColor = UIColor.Theme1.white
            
            cell.totalFiberLabel.text = String(format: "%.2f g", ingredient.nutrition.fiber)
            cell.totalSugarLabel.text = String(format: "%.2f g", ingredient.nutrition.sugar)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SaveIngredientTableViewCell.identifier, for: indexPath) as! SaveIngredientTableViewCell
            cell.ingredient = ingredient
            cell.backgroundColor = UIColor.Theme1.white
            cell.delegate = self
            cell.selectionStyle = .none
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                if !self.updateButton.isEnabled {
                    cell.saveButton.isHidden = true
                    cell.discardButton.isHidden = true
                } else {
                    cell.saveButton.isHidden = false
                    cell.discardButton.isHidden = false
                }
            }
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Nutrition Facts"
        default: return ""
        }
    }
}
