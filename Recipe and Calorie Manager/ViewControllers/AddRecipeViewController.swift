//
//  AddRecipeViewController.swift
//  Recipe and Calorie Manager
//
//  Created by Kazunobu Someya on 2021-01-19.
//

import UIKit

class AddRecipeViewController: UIViewController {
    
    let recipeTextField: UITextField = {
       let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Chicken Parmigiano"
        tf.font = .systemFont(ofSize: 25)
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.becomeFirstResponder()
        tf.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    let addButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add New Recipe", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.widthAnchor.constraint(equalToConstant: 250).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(addNewRecipe), for: .touchUpInside)
        button.isEnabled = false
        button.alpha = 0.5
    return button
    }()
    
    let vStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .fill
        sv.spacing = 8
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
        vStackView.addArrangedSubview(recipeTextField)
        vStackView.addArrangedSubview(addButton)
        view.addSubview(vStackView)
        
        vStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        vStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    @objc func addNewRecipe() {
        let newRecipeVC = AddIngredientsViewController()
        newRecipeVC.recipeTitle = recipeTextField.text
        navigationController?.pushViewController(newRecipeVC, animated: true)
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

}
