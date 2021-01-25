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
        amountPerServingLabel.backgroundColor = #colorLiteral(red: 1, green: 0.9697935916, blue: 0.7963718291, alpha: 1)
            
        let disclaimerLabel = UILabel()
        disclaimerLabel.text = " * The % Daily Value (DV) tells you how much a nutrient in a serving of food contributes to a daily diet. 2,000 calories a day is used for general nutrition advice. (FDA.gov)"
        disclaimerLabel.setMargins()
        disclaimerLabel.textAlignment = .justified
        disclaimerLabel.numberOfLines = 0
        disclaimerLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        disclaimerLabel.textColor = UIColor.Theme1.black
        disclaimerLabel.backgroundColor = #colorLiteral(red: 1, green: 0.9697935916, blue: 0.7963718291, alpha: 1)
        
        let caloriesLabel = UILabel()
        caloriesLabel.text = "Calories"
        caloriesLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        caloriesLabel.textAlignment = .natural
        caloriesLabel.textColor = UIColor.Theme1.black
        
        totalCaloriesLabel.font = UIFont.systemFont(ofSize: 20)
        let hSV1 = UIStackView(arrangedSubviews: [caloriesLabel, UIView(), totalCaloriesLabel])
        hSV1.axis = .horizontal
        hSV1.alignment = .bottom
        hSV1.alignment = .leading
        hSV1.distribution = .fill
        hSV1.backgroundColor = #colorLiteral(red: 1, green: 0.9697935916, blue: 0.7963718291, alpha: 1)
        
        let percentDailyValue = UILabel()
        percentDailyValue.text = "% Daily Value*"
        percentDailyValue.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        percentDailyValue.textAlignment = .right
        percentDailyValue.textColor = UIColor.Theme1.black
        
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
        
        let hStackView = UIStackView(arrangedSubviews: [nameLabel, total, UIView(), dv])
        hStackView.axis = .horizontal
        hStackView.alignment = .trailing
        hStackView.distribution = .fill
        hStackView.backgroundColor = #colorLiteral(red: 1, green: 0.9697935916, blue: 0.7963718291, alpha: 1)
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
