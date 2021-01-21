//
//  AddIngredientsViewController.swift
//  Recipe and Calorie Manager
//
//  Created by Gil Jetomo on 2021-01-19.
//

import UIKit

class AddIngredientsViewController: UIViewController {

    let cellId = "cellId"
    var recipeTitle: String?
    var ingredients = [(serving: String, nutrition: Nutrition?)]()
    
    var caloriesTotal: Double? {
        willSet(total) { caloriesTotalCountLabel.text = "\((total! * 100).rounded()/100) g" }
    }
    var carbsTotal: Double? {
        willSet(total) { carbsTotalCountLabel.text = "\((total! * 100).rounded()/100) g" }
    }
    var proteinTotal: Double? {
        willSet(total) { proteinTotalCountLabel.text = "\((total! * 100).rounded()/100) g" }
    }
    var fatTotal: Double? {
        willSet(total) { fatTotalCountLabel.text = "\((total! * 100).rounded()/100) g" }
    }
    var fiberTotal: Double? {
        willSet(total) { fiberTotalCountLabel.text = "\((total! * 100).rounded()/100) g" }
    }
    
    let ingredientTextField: UITextField = {
       let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "1 tbsp canola oil"
        tf.font = .systemFont(ofSize: 25)
        tf.widthAnchor.constraint(equalToConstant: 270).isActive = true
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tf.becomeFirstResponder()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    let addButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
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
        sv.alignment = .fill
        sv.spacing = 10
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
    
    var tableview = UITableView()
    
    var caloriesTotalCountLabel = UILabel()
    var carbsTotalCountLabel = UILabel()
    var proteinTotalCountLabel = UILabel()
    var fatTotalCountLabel = UILabel()
    var fiberTotalCountLabel = UILabel()
    var alert: UIAlertController!
    
    func makeLabelTotals(with string: String, isHeader: Bool) -> UILabel {
        let label = UILabel()
        label.text = string
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        if isHeader {
            label.font = UIFont.boldSystemFont(ofSize: 17)
            label.layer.masksToBounds = true
            label.backgroundColor = #colorLiteral(red: 0.7829411976, green: 0.9072662751, blue: 1, alpha: 1)
            label.layer.cornerRadius = 6
        } else {
            label.font = UIFont.systemFont(ofSize: 17)
        }
        return label
    }
    
    func makeTotalsStackView(with labels: [(UILabel, UILabel)]) -> UIStackView {
    
        let hStackView = UIStackView()
        for view in labels {
            let (heading, total) = view
            let vStackView = UIStackView(arrangedSubviews: [heading, total])
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
 
        return hStackView
    }
    
    fileprivate func setupStackViews() {
        //title labels, let is used as the 'titles' are constant
        let caloriesTotalLabel = makeLabelTotals(with: "Calories", isHeader: true)
        let carbsTotalLabel = makeLabelTotals(with: "Carbs", isHeader: true)
        let proteinTotalLabel = makeLabelTotals(with: "Protein", isHeader: true)
        let fatTotalLabel = makeLabelTotals(with: "Fat", isHeader: true)
        let fiberTotalLabel = makeLabelTotals(with: "Fiber", isHeader: true)
        //total labels are declared as variable so that their text property can be updated
        caloriesTotalCountLabel = makeLabelTotals(with: "0 g", isHeader: false)
        carbsTotalCountLabel = makeLabelTotals(with: "0 g", isHeader: false)
        proteinTotalCountLabel = makeLabelTotals(with: "0 g", isHeader: false)
        fatTotalCountLabel = makeLabelTotals(with: "0 g", isHeader: false)
        fiberTotalCountLabel = makeLabelTotals(with: "0 g", isHeader: false)
        
        let totalLabels = [(caloriesTotalLabel, caloriesTotalCountLabel),
                           (carbsTotalLabel, carbsTotalCountLabel),
                           (proteinTotalLabel, proteinTotalCountLabel),
                           (fatTotalLabel, fatTotalCountLabel),
                           (fiberTotalLabel, fiberTotalCountLabel)
        ]
        
        let totalsStackViews = makeTotalsStackView(with: totalLabels)
        
        hStackView.addArrangedSubview(ingredientTextField)
        hStackView.addArrangedSubview(addButton)
   
        vStackView.addArrangedSubview(hStackView)
        vStackView.addArrangedSubview(totalsStackViews)
        
        view.addSubview(vStackView)
        
        vStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                self.updateTableViewAndTotals(with: serving, and: ingredient)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    fileprivate func updateTableViewAndTotals(with serving: String, and ingredient: (Ingredient)) {
        DispatchQueue.main.async { [self] in
            if ingredient.items.count > 0 {
                ingredients.insert((serving: serving, nutrition: ingredient.items[0]), at: 0)
                tableview.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .top)
                
                caloriesTotal = ingredients.map { $0.nutrition!.calories }.reduce(0){ $0 + $1 }
                carbsTotal = ingredients.map { $0.nutrition!.carbohydrates }.reduce(0){ $0 + $1}
                proteinTotal = ingredients.map { $0.nutrition!.protein }.reduce(0){ $0 + $1 }
                fatTotal = ingredients.map { $0.nutrition!.totalFat }.reduce(0){ $0 + $1 }
                fiberTotal = ingredients.map { $0.nutrition!.fiber }.reduce(0){ $0 + $1}
                
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
        guard let text = sender.text, text.count > 3 else {
            addButton.alpha = 0.5
            addButton.isEnabled = false
            return
        }
        addButton.alpha = 1.0
        addButton.isEnabled = true
    }
    
    fileprivate func setupTableView() {
        tableview = UITableView(frame: view.frame, style: .insetGrouped)
        view.addSubview(tableview)
        
        tableview.register(IngredientTableViewCell.self, forCellReuseIdentifier: cellId)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.contentInsetAdjustmentBehavior = .never
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.topAnchor.constraint(equalTo: vStackView.bottomAnchor, constant: 12).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
    }
}

extension AddIngredientsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredient = ingredients[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! IngredientTableViewCell
        
        cell.update(with: ingredient)
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.5
        return cell
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
        switch section {
        case 0: return "Ingredients"
        default: fatalError()
        }
    }
}
