//
//  RecipeListViewController.swift
//  Recipe and Calorie Manager
//
//  Created by Kazunobu Someya on 2021-01-19.
//

import UIKit


class RecipeListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    let cellId = "RecipeListCell"
    let meals = ["Breakfast","Lunch","Snacks","Dinner"]
    
    let myTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "Recipe List"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(myTable)
        setupTableView()
    }
    
    func setupTableView() {
        myTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        myTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        myTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        myTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        myTable.delegate = self
        myTable.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel!.text = meals[indexPath.row]
        return cell
    }
}
