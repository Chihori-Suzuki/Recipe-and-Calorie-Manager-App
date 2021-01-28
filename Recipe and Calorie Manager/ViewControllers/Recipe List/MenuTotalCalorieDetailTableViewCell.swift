//
//  MenuTotalCalorieDetailTableViewCell.swift
//  Recipe and Calorie Manager
//
//  Created by Kazunobu Someya on 2021-01-24.
//

import UIKit

class MenuTotalCalorieDetailTableViewCell: UITableViewCell {
    static let identifier = "MenuTotalCalorie"
    // make UILabel for Recipe title
    let recipeTitleLabel: UILabel = {
        let recipeTitle = UILabel()
        recipeTitle.numberOfLines = 0
        recipeTitle.textAlignment = .left
        recipeTitle.setMargins()
        recipeTitle.font = UIFont(name: "ArialRoundedMTBold", size: 21)
        recipeTitle.textColor = UIColor.Theme1.brown
        return recipeTitle
    }()
    
    // make UILabel for totalCalorie
    let totalCalorieLabel: UILabel = {
        let totalCalorie = UILabel()
        totalCalorie.numberOfLines = 0
        totalCalorie.textAlignment = .center
        totalCalorie.setMargins()
        totalCalorie.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        totalCalorie.textColor = UIColor.Theme1.orange
        return totalCalorie
    }()
    
    lazy var hStackView: UIStackView = {
        let horizontalStack = UIStackView(arrangedSubviews: [recipeTitleLabel, totalCalorieLabel])
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .bottom
        horizontalStack.distribution = .fill
        horizontalStack.spacing = 0
        return horizontalStack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(hStackView)
//        contentView.heightAnchor.constraint(equalTo: hStackView.heightAnchor, multiplier: 1).isActive = true
        setupHorizontalStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHorizontalStackView() {
        hStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        hStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        hStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        hStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
    }
    
    
    func update(_ cellTitle: String, _ cellTotalCalories: Double) {
        recipeTitleLabel.text = cellTitle
        totalCalorieLabel.text = String(format: "Calories: %.2f", cellTotalCalories)
    }
}
