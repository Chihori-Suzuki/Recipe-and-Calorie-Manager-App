//
//  showProfileViewController.swift
//  Recipe and Calorie Manager
//
//  Created by Chiori Suzuki on 2021/01/21.
//

import UIKit

class showProfileViewController: UIViewController {

    
    // ScrollView
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // profileimage
    let profileImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "profile.png"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.widthAnchor.constraint(equalToConstant: 100).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return iv
    }()
    
    // stack View
    let mainSV: UIStackView = { // All (+image + tableView + button)
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let headSV: UIStackView = { // + image
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let nameSV: UIStackView = { // name, BMI and Classification
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let bmiSV: UIStackView = { // BMI
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let cfSV: UIStackView = { // Classification
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // Label
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "name"
        return lb
    }()
    
    let bmiLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "BMI"
        return lb
    }()
    let bmiValLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "BMI"
        return lb
    }()
    let cfLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "BMI"
        return lb
    }()
    let cfValLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "BMI"
        return lb
    }()
    
    // tableView
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let cellId = "cellId"
    var sectionTitle: [String] = ["Personal Profile"]
    var personalData = [Profile]()
    
    // editButton
    let editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Edit Profile", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 8
//        button.addTarget(self, action: #selector(addNewPerson), for: .touchUpInside)
        button.alpha = 0.5
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = .white
        title = "Personal Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(scrollView)
        scrollView.addSubview(mainSV)
        setSVConfig()
        
        setPersonalData()
        
    }
    func setSVConfig() {
        /* scrollView **********/
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        /* mainSV **********/
        mainSV.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        mainSV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        mainSV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        mainSV.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        
        mainSV.addArrangedSubview(headSV)
        mainSV.addArrangedSubview(tableView)
        mainSV.addArrangedSubview(editButton)
        mainSV.axis = .vertical
        mainSV.alignment = .fill
        mainSV.distribution = .fill
        mainSV.spacing = 50
        
        /* headSV **********/
        headSV.addArrangedSubview(profileImage)
        headSV.addArrangedSubview(nameSV)
        headSV.axis = .horizontal
        headSV.alignment = .fill
        headSV.spacing = 10
        
        /* nameSV **********/
        nameSV.addArrangedSubview(nameLabel)
        nameSV.addArrangedSubview(bmiSV)
        nameSV.addArrangedSubview(cfSV)
        nameSV.axis = .vertical
        nameSV.alignment = .fill
        nameSV.spacing = 10
        
        /* bmiSV **********/
        bmiSV.addArrangedSubview(bmiLabel)
        bmiSV.addArrangedSubview(bmiValLabel)
        bmiSV.axis = .horizontal
        bmiSV.alignment = .fill
        bmiSV.spacing = 10
        
        /* cfSV **********/
        cfSV.addArrangedSubview(cfLabel)
        cfSV.addArrangedSubview(cfValLabel)
        cfSV.axis = .horizontal
        cfSV.alignment = .fill
        cfSV.spacing = 10
        
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        
    }
    
    func setPersonalData(){
        // UserDefaults
        let defaults = UserDefaults.standard
        let savedName = defaults.object(forKey: "Name") as? String ?? String()
        var savedBirth = defaults.object(forKey: "Birthday") as? Date ?? Date()
        let savedGender = defaults.object(forKey: "Gender") as? String ?? String()
        let savedWeight = defaults.double(forKey: "weight")
        let savedHeight = defaults.double(forKey: "height")
        let savedActivity = defaults.object(forKey: "ActivityType") as? String ?? String()
        
        print("aaaaaaaaaaaa")
        print(savedName)
        
//        let age =
        personalData.append(Profile(palameter: "Name", value: savedName))
        personalData.append(Profile(palameter: "Birthday", value: "28"))
        personalData.append(Profile(palameter: "Gender", value: savedGender))
        personalData.append(Profile(palameter: "Weight", value: "\(savedWeight)"))
        personalData.append(Profile(palameter: "height", value: "\(savedHeight)"))
        personalData.append(Profile(palameter: "ActivityType", value: savedActivity))
        
        
    }
}

extension showProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personalData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = personalData[indexPath.row].palameter
        cell.detailTextLabel?.text = "AAAA"
        // 
//        cell.detailTextLabel?.text = personalData[indexPath.row].value
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
}

