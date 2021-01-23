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
    lazy var labels: [(name: String, isBold: Bool, total: UILabel)] = [("Total Fat", true, totalFat), ("Saturated Fat", false, totalSatFat),
                                                          ("Cholesterol", true, totalCholesterol), ("Sodium", true, totalSodium),
                                                          ("Total Carbohydrates", true, totalCarbs), ("Total Sugars", false, totalSugar),
                                                          ("Fiber", false, totalFiber), ("Protein", true, totalProtein),
                                                          ("Potassium", false, totalPotassium)]
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let vStackView = UIStackView()
        vStackView.axis = .vertical
        vStackView.alignment = .fill
        vStackView.distribution = .fill
        vStackView.spacing = 3
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
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let percentLabel = UILabel()
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        percentLabel.text = "%"
        percentLabel.font = UIFont.systemFont(ofSize: 18)
        
        let hStackView = UIStackView(arrangedSubviews: [nameLabel, total, UIView(), percentLabel])
        hStackView.axis = .horizontal
        hStackView.alignment = .trailing
        hStackView.distribution = .fill
        hStackView.backgroundColor = #colorLiteral(red: 1, green: 0.9697935916, blue: 0.7963718291, alpha: 1)
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.spacing = 8
        
        return hStackView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
