//
//  NutritionFactsTableViewCell.swift
//  Recipe and Calorie Manager
//
//  Created by Macbook Pro on 2021-01-22.
//

import UIKit

class NutritionFactsTableViewCell: UITableViewCell {
    
    static let identifier = "nutritionCell"
    var totalFat = UILabel()
    var totalCholesterol = UILabel()
    var totalSatFat = UILabel()
    var totalCarbs = UILabel()
    var totalFiber = UILabel()
    var totalSugar = UILabel()
    var totalSodium = UILabel()
    var totalPotassium = UILabel()
    var totalProtein = UILabel()
    var totalCalories = UILabel()
    lazy var labels: [(name: String, isBold: Bool, total: UILabel)] = [("Total Fat", true, totalFat), ("Saturated Fat", false, totalSatFat),
                                                          ("Cholesterol", true, totalCholesterol), ("Sodium", true, totalSodium),
                                                          ("Total Carbohydrates", true, totalCarbs), ("Total Sugars", false, totalSugar),
                                                          ("Fiber", false, totalFiber), ("Protein", true, totalProtein),
                                                          ("Potassium", false, totalPotassium)]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        

        

        
        let amountPerServingLabel = UILabel()
        amountPerServingLabel.text = "Amount Per Serving"
        amountPerServingLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        amountPerServingLabel.textAlignment = .left
        amountPerServingLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        amountPerServingLabel.backgroundColor = #colorLiteral(red: 1, green: 0.9697935916, blue: 0.7963718291, alpha: 1)
        
        let caloriesLabel = UILabel()
        caloriesLabel.text = "Calories"
        caloriesLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        caloriesLabel.textAlignment = .natural
        
        totalCalories.font = UIFont.systemFont(ofSize: 20)
        let hSV1 = UIStackView(arrangedSubviews: [caloriesLabel, UIView(), totalCalories])
        hSV1.axis = .horizontal
        hSV1.alignment = .bottom
        hSV1.alignment = .leading
        hSV1.distribution = .fill
        hSV1.backgroundColor = #colorLiteral(red: 1, green: 0.9697935916, blue: 0.7963718291, alpha: 1)
        
        let percentDailyValue = UILabel()
        percentDailyValue.text = "% Daily Value"
        percentDailyValue.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        percentDailyValue.textAlignment = .right
        
        let hSV2 = UIStackView(arrangedSubviews: [UIView(), percentDailyValue])
        hSV2.axis = .horizontal
        hSV2.alignment = .bottom
        hSV2.distribution = .fill
        hSV2.backgroundColor = #colorLiteral(red: 1, green: 0.9697935916, blue: 0.7963718291, alpha: 1)

        let vStackView = UIStackView(arrangedSubviews: [amountPerServingLabel, hSV1, hSV2])
        vStackView.axis = .vertical
        vStackView.alignment = .fill
        vStackView.distribution = .fill
        vStackView.spacing = 3
        //this autolayout boolean is only needed to display the elements
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for label in labels {
            let hStackView = makeLabels(with: label.name, isBold: label.isBold, total: label.total)
            vStackView.addArrangedSubview(hStackView)
        }
        
        contentView.addSubview(vStackView)
        
        vStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        
        contentView.heightAnchor.constraint(equalTo: vStackView.heightAnchor, multiplier: 1).isActive = true
        
    }
    func makeLabels(with name: String, isBold: Bool, total: UILabel) -> UIStackView {
        
        let nameLabel = UILabel()
        isBold ? (nameLabel.text = name) : (nameLabel.text = "  \(name)")
        isBold ? (nameLabel.font = UIFont.boldSystemFont(ofSize: 19)) : (nameLabel.font = UIFont.systemFont(ofSize: 18))
        
        let percentLabel = UILabel()
        percentLabel.text = "%"
        percentLabel.font = UIFont.systemFont(ofSize: 18)
        
        let hStackView = UIStackView(arrangedSubviews: [nameLabel, total, UIView(), percentLabel])
        hStackView.axis = .horizontal
        hStackView.alignment = .trailing
        hStackView.distribution = .fill
        hStackView.backgroundColor = #colorLiteral(red: 1, green: 0.9697935916, blue: 0.7963718291, alpha: 1)
        hStackView.spacing = 8
        
        return hStackView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
