//
//  MenuTotalCalorieDetailTableViewCell.swift
//  Recipe and Calorie Manager
//
//  Created by Kazunobu Someya on 2021-01-24.
//

import UIKit

class MenuTotalCalorieDetailTableViewCell: UITableViewCell {
    // make UILabel for Recipe title
    let recipeTitleLabel: UILabel = {
        let recipeTitle = UILabel()
        recipeTitle.translatesAutoresizingMaskIntoConstraints = false
        recipeTitle.numberOfLines = 0
        recipeTitle.clipsToBounds = true
        recipeTitle.textAlignment = .center
        recipeTitle.font = UIFont.boldSystemFont(ofSize: 20)
        recipeTitle.widthAnchor.constraint(equalToConstant: 150).isActive = true
        return recipeTitle
    }()
    
    // make UILabel for totalCalorie
    let totalCalorieLabel: UILabel = {
        let totalCalorie = UILabel()
        totalCalorie.translatesAutoresizingMaskIntoConstraints = false
        totalCalorie.clipsToBounds = true
        totalCalorie.textAlignment = .center
        totalCalorie.font = UIFont.boldSystemFont(ofSize: 20)
        totalCalorie.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return totalCalorie
    }()
    
    lazy var hStackView: UIStackView = {
        let horizontalStack = UIStackView(arrangedSubviews: [recipeTitleLabel,totalCalorieLabel])
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.clipsToBounds = false
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.distribution = .equalCentering
        horizontalStack.spacing = 10
        horizontalStack.layer.cornerRadius = 10
        horizontalStack.layer.borderWidth = 1
        return horizontalStack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(hStackView)
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
        recipeTitleLabel.text = "\(cellTitle)"
        totalCalorieLabel.text = String(format: "%.2f", cellTotalCalories)
    }
    
    // make margin between two tableview cells
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        contentView.frame = contentView.frame.inset(by: padding)
    }
}
