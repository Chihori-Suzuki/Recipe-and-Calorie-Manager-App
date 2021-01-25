//
//  SaveIngredientTableViewCell.swift
//  Recipe and Calorie Manager
//
//  Created by Macbook Pro on 2021-01-23.
//

import UIKit

protocol saveIngredientButtonTapped: class {
    func saveButtonTapped()
}

class SaveIngredientTableViewCell: UITableViewCell {

    static let identifier = "saveIngredient"
    
    var ingredient: Ingredient?
    weak var delegate: saveIngredientButtonTapped?
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.1966013642, green: 0.1966013642, blue: 0.1966013642, alpha: 1), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.backgroundColor = #colorLiteral(red: 0.6553853061, green: 0.8888800762, blue: 0.3222138089, alpha: 1)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(saveRecipe(_:)), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(saveButton)
        contentView.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func saveRecipe(_ sender: UIButton) {
        UIView.animate(withDuration: 0.10) {
            sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        } completion: { (_) in
            UIView.animate(withDuration: 0.10) {
                sender.transform = CGAffineTransform.identity
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.delegate?.saveButtonTapped()
        }
    }
}