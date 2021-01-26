//
//  CheckIngredientsDetailViewController.swift
//  Recipe and Calorie Manager
//
//  Created by Kazunobu Someya on 2021-01-25.
//

import UIKit

class CheckIngredientsDetailViewController: UIViewController {
    
    let cellId = "CheckIngredientsDetail"
    
    let sectionTitles = ["Ingredients", "Nutrition Facts", ""]
    let groups = ["soso","ll","usl","oslv","slala"]
    
    lazy var myTable: UITableView = {
        let table = UITableView(frame: view.frame, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
//        table.register(IngredientTableViewCell.self, forCellReuseIdentifier: IngredientTableViewCell.identifier)
//        table.register(NutritionFactsTableViewCell.self, forCellReuseIdentifier: NutritionFactsTableViewCell.identifier)
//        table.register(SaveRecipeTableViewCell.self, forCellReuseIdentifier: SaveRecipeTableViewCell.identifier)
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        table.delegate = self
        table.dataSource = self
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Detail"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    func setupTableView() {
        view.addSubview(myTable)
        myTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        myTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        myTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        myTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
}


extension CheckIngredientsDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let group = groups[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        
        
//        cell.update(group)
        cell.textLabel?.text = sectionTitles[indexPath.row]
        return cell
    }

}

extension CheckIngredientsDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

    }
}


