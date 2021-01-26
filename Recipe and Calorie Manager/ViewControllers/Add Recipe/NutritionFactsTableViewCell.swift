//
//  NutritionFactsTableViewCell.swift
//  Recipe and Calorie Manager
//
//  Created by Macbook Pro on 2021-01-22.
//

import UIKit

class NutritionFactsTableViewCell: UITableViewCell {
    
    static let identifier = "nutritionCell"
    var totalFatLabel = UILabel()
    var totalCholesterolLabel = UILabel()
    var totalSatFatLabel = UILabel()
    var totalCarbsLabel = UILabel()
    var totalFiberLabel = UILabel()
    var totalSugarLabel = UILabel()
    var totalSodiumLabel = UILabel()
    var totalPotassiumLabel = UILabel()
    var totalProteinLabel = UILabel()
    var totalCaloriesLabel = UILabel()
    var totalServingLabel = UILabel()
    
    var totalFatDV = UILabel()
    var totalCholesterolDV = UILabel()
    var totalSatFatDV = UILabel()
    var totalCarbsDV = UILabel()
    var totalSodiumDV = UILabel()
    var totalPotassiumDV = UILabel()
    var totalProteinDV = UILabel()
    
    lazy var labels: [(name: String, isBold: Bool, total: UILabel, dailyValue: UILabel)] =
         [("Total Fat", true, totalFatLabel, totalFatDV),
          ("Saturated Fat", false, totalSatFatLabel, totalSatFatDV),
          ("Cholesterol", true, totalCholesterolLabel, totalCholesterolDV),
          ("Sodium", true, totalSodiumLabel, totalSodiumDV),
          ("Total Carbohydrates", true, totalCarbsLabel, totalCarbsDV),
          ("Total Sugars", false, totalSugarLabel, UILabel()),
          ("Fiber", false, totalFiberLabel, UILabel()),
          ("Protein", true, totalProteinLabel, totalProteinDV),
          ("Potassium", false, totalPotassiumLabel, totalPotassiumDV)]
    
    fileprivate func setupLayout() {
        let amountPerServingLabel = UILabel()
        amountPerServingLabel.text = "Amount Per Serving"
        amountPerServingLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        amountPerServingLabel.textAlignment = .left
        amountPerServingLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        amountPerServingLabel.textColor = UIColor.Theme1.black
            
        totalServingLabel.font = UIFont.systemFont(ofSize: 19)
        totalServingLabel.textColor = UIColor.Theme1.black
        
        let hServingSV = UIStackView(arrangedSubviews: [amountPerServingLabel, UIView(), totalServingLabel])
        hServingSV.axis = .horizontal
        hServingSV.distribution = .fill
        hServingSV.alignment = .fill
        
        let disclaimerLabel = UILabel()
        disclaimerLabel.text = " * The % Daily Value (DV) tells you how much a nutrient in a serving of food contributes to a daily diet. 2,000 calories a day is used for general nutrition advice. (FDA.gov)"
        disclaimerLabel.setMargins()
        disclaimerLabel.textAlignment = .justified
        disclaimerLabel.numberOfLines = 0
        disclaimerLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        disclaimerLabel.textColor = UIColor.Theme1.black
        
        let caloriesLabel = UILabel()
        caloriesLabel.text = "Calories"
        caloriesLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        caloriesLabel.textAlignment = .natural
        caloriesLabel.textColor = UIColor.Theme1.black

        totalCaloriesLabel.font = UIFont.boldSystemFont(ofSize: 20)
        totalCaloriesLabel.textColor = UIColor.Theme1.black
        let hSV1 = UIStackView(arrangedSubviews: [caloriesLabel, UIView(), totalCaloriesLabel])
        hSV1.axis = .horizontal
        hSV1.alignment = .bottom
        hSV1.distribution = .fill

        let percentDailyValue = UILabel()
        percentDailyValue.text = "% Daily Value*"
        percentDailyValue.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        percentDailyValue.textAlignment = .right
        percentDailyValue.textColor = UIColor.Theme1.black
       
        let vStackView = UIStackView(arrangedSubviews: [hServingSV, hSV1, percentDailyValue])
        vStackView.axis = .vertical
        vStackView.alignment = .fill
        vStackView.distribution = .fill
        vStackView.spacing = 3
        vStackView.backgroundColor = #colorLiteral(red: 1, green: 0.9697935916, blue: 0.7963718291, alpha: 1)
        //this autolayout boolean is only needed to display all elements
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for label in labels {
            let hStackView = makeLabels(with: label.name, isBold: label.isBold, total: label.total, dv: label.dailyValue)
            vStackView.addArrangedSubview(hStackView)
        }
        vStackView.addArrangedSubview(UIView())
        vStackView.addArrangedSubview(UIView())
        vStackView.addArrangedSubview(disclaimerLabel)
        contentView.addSubview(vStackView)
        contentView.heightAnchor.constraint(equalTo: vStackView.heightAnchor, multiplier: 1).isActive = true
        
        vStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
    }
    
    func makeLabels(with name: String, isBold: Bool, total: UILabel, dv: UILabel) -> UIStackView {
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.textColor = UIColor.Theme1.black
        !isBold ? nameLabel.setMargins() : nil
        isBold ? (nameLabel.font = UIFont.boldSystemFont(ofSize: 19)) : (nameLabel.font = UIFont.systemFont(ofSize: 18))
        
        total.textColor = UIColor.Theme1.black
        dv.textColor = UIColor.Theme1.black
        
        let hStackView = UIStackView(arrangedSubviews: [nameLabel, total, UIView(), dv])
        hStackView.axis = .horizontal
        hStackView.alignment = .trailing
        hStackView.distribution = .fill
        hStackView.spacing = 8
        
        return hStackView
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with ingredients: [Ingredient]) {
        let totalFat = ingredients.map { $0.nutrition.totalFat }.reduce(0){ $0 + $1 }
        totalFatLabel.text = String(format: "%.2f g", totalFat)
        totalFatDV.text = (String(format: "%.2f", (totalFat/DailyValue.totalFat.rawValue)*100)+" %")
        
        let totalCholesterol = ingredients.map { $0.nutrition.cholesterol }.reduce(0){ $0 + $1 }
        totalCholesterolLabel.text = String(format: "%.2f mg", totalCholesterol)
        totalCholesterolDV.text = (String(format: "%.2f", (totalCholesterol/DailyValue.cholesterol.rawValue)*100)+" %")
        
        let totalSodium = ingredients.map { $0.nutrition.sodium }.reduce(0){ $0 + $1 }
        totalSodiumLabel.text = String(format: "%.2f mg", totalSodium)
        totalSodiumDV.text = (String(format: "%.2f", (totalSodium/DailyValue.totalFat.rawValue)*100)+" %")

        let totalCarbs = ingredients.map { $0.nutrition.carbohydrates }.reduce(0){ $0 + $1 }
        totalCarbsLabel.text = String(format: "%.2f g", totalCarbs)
        totalCarbsDV.text = (String(format: "%.2f", (totalCarbs/DailyValue.totalFat.rawValue)*100)+" %")

        let totalProtein = ingredients.map { $0.nutrition.protein }.reduce(0){ $0 + $1 }
        totalProteinLabel.text = String(format: "%.2f g", totalProtein)
        totalProteinDV.text = (String(format: "%.2f", (totalProtein/DailyValue.totalFat.rawValue)*100)+" %")

        let totalPotassium = ingredients.map { $0.nutrition.potassium }.reduce(0){ $0 + $1 }
        totalPotassiumLabel.text = String(format: "%.2f mg", totalPotassium)
        totalPotassiumDV.text = (String(format: "%.2f", (totalPotassium/DailyValue.totalFat.rawValue)*100)+" %")

        let totalSatFat = ingredients.map { $0.nutrition.fat }.reduce(0){ $0 + $1 }
        totalSatFatLabel.text = String(format: "%.2f g", totalSatFat)
        totalSatFatDV.text = (String(format: "%.2f", (totalSatFat/DailyValue.totalFat.rawValue)*100)+" %")
        
        let totalServingSize = ingredients.map { $0.nutrition.serving }.reduce(0){ $0 + $1 }
        totalServingLabel.text = String(format: "%.2f g", totalServingSize)
        
        totalCaloriesLabel.text = String(format: "%.2f", ingredients.map { $0.nutrition.calories }.reduce(0){ $0 + $1 })
        totalFiberLabel.text = String(format: "%.2f g", ingredients.map { $0.nutrition.fiber }.reduce(0){ $0 + $1 })
        totalSugarLabel.text = String(format: "%.2f g", ingredients.map { $0.nutrition.sugar }.reduce(0){ $0 + $1 })
    }
    
    func update(with ingredient: Ingredient) {
        let totalFat = ingredient.nutrition.totalFat
        totalFatLabel.text = String(format: "%.2f g", totalFat)
        totalFatDV.text = (String(format: "%.2f", (totalFat/DailyValue.totalFat.rawValue)*100)+" %")
        
        let totalCholesterol = ingredient.nutrition.cholesterol
        totalCholesterolLabel.text = String(format: "%.2f mg", totalCholesterol)
        totalCholesterolDV.text = (String(format: "%.2f", (totalCholesterol/DailyValue.cholesterol.rawValue)*100)+" %")
        
        let totalSodium = ingredient.nutrition.sodium
        totalSodiumLabel.text = String(format: "%.2f mg", totalSodium)
        totalSodiumDV.text = (String(format: "%.2f", (totalSodium/DailyValue.sodium.rawValue)*100)+" %")
        
        let totalCarbs = ingredient.nutrition.carbohydrates
        totalCarbsLabel.text = String(format: "%.2f g", totalCarbs)
        totalCarbsDV.text = (String(format: "%.2f", (totalCarbs/DailyValue.totalCarbs.rawValue)*100)+" %")
        
        let totalProtein = ingredient.nutrition.protein
        totalProteinLabel.text = String(format: "%.2f g", totalProtein)
        totalProteinDV.text = (String(format: "%.2f", (totalProtein/DailyValue.protein.rawValue)*100)+" %")
        
        let totalPotassium = ingredient.nutrition.potassium
        totalPotassiumLabel.text = String(format: "%.2f mg", totalPotassium)
        totalPotassiumDV.text = (String(format: "%.2f", (totalPotassium/DailyValue.potassium.rawValue)*100)+" %")
        
        let totalSatFat = ingredient.nutrition.fat
        totalSatFatLabel.text = String(format: "%.2f g", totalSatFat)
        totalSatFatDV.text = (String(format: "%.2f", (totalSatFat/DailyValue.satFat.rawValue)*100)+" %")
        
        let totalServing = ingredient.nutrition.serving
        totalServingLabel.text = String(format: "%.2f g", totalServing)
        
        totalCaloriesLabel.text = String(format: "%.2f", ingredient.nutrition.calories)
    }
}

extension UILabel {
    func setMargins(margin: CGFloat = 8) {
        if let textString = self.text {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.firstLineHeadIndent = margin
            paragraphStyle.headIndent = margin
            paragraphStyle.tailIndent = -margin
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}
