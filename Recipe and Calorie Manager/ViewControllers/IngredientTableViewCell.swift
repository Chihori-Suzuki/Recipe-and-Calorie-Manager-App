//
//  IngredientTableViewCell.swift
//  Recipe and Calorie Manager
//
//  Created by Macbook Pro on 2021-01-19.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    let ingredientLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let caloriesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = " Calories: "
        label.backgroundColor = #colorLiteral(red: 0.9250274271, green: 1, blue: 0.8999154439, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let proteinLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = " Protein: "
        label.numberOfLines = 0
        label.backgroundColor = #colorLiteral(red: 0.9250274271, green: 1, blue: 0.8999154439, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let vStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.spacing = 0
        sv.widthAnchor.constraint(equalToConstant: 150).isActive = true
        return sv
        
    }()
    
    let hStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .fill
        return sv
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        vStackView.addArrangedSubview(caloriesLabel)
        vStackView.addArrangedSubview(proteinLabel)
        hStackView.addArrangedSubview(ingredientLabel)
        hStackView.addArrangedSubview(vStackView)
        
        contentView.addSubview(hStackView)
        
        hStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        hStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        hStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        hStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with nutrition: Nutrition) {
        caloriesLabel.text = String(nutrition.calories)
    }
    
    
}
