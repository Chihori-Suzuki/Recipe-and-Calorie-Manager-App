//
//  showProfileViewController.swift
//  Recipe and Calorie Manager
//
//  Created by Chiori Suzuki on 2021/01/21.
//

import UIKit

class showProfileViewController: UIViewController, EditProfileDelegate {
    
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
    
    let bmrSV: UIStackView = { // BMR
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
    let bmrLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "BMR"
        return lb
    }()
    let bmrValLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "00"
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
        lb.text = "00"
        return lb
    }()
    let cfLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Classification"
        return lb
    }()
    let cfValLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "normal"
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
        button.addTarget(self, action: #selector(didTapEditBtn), for: .touchUpInside)
        button.alpha = 0.5
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Theme1.blue, NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 30)!]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = UIColor.Theme1.white
        title = "Personal Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(scrollView)
        scrollView.addSubview(mainSV)
        setSVConfig()
        
        setPersonalData()
        navigationItem.hidesBackButton = true
        
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
        nameSV.addArrangedSubview(bmrSV)
        nameSV.addArrangedSubview(bmiSV)
        nameSV.addArrangedSubview(cfSV)
        nameSV.axis = .vertical
        nameSV.alignment = .fill
        nameSV.spacing = 10
        
        /* bmrSV **********/
        bmrSV.addArrangedSubview(bmrLabel)
        bmrSV.addArrangedSubview(bmrValLabel)
        bmrSV.axis = .horizontal
        bmrSV.alignment = .fill
        bmrSV.spacing = 10
        
        
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
        
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        
    }
    
    func setPersonalData(){
        // UserDefaults
        let defaults = UserDefaults.standard
        let savedName = defaults.object(forKey: "Name") as? String ?? String()
        let savedBirth = defaults.object(forKey: "Birthday") as? Date ?? Date()
        let savedGender = defaults.object(forKey: "Gender") as? String ?? String()
        let savedWeight = defaults.double(forKey: "weight")
        let savedHeight = defaults.double(forKey: "height")
        let savedActivity = defaults.object(forKey: "ActivityType") as? String ?? String()
        
        let now = NSDate()
        let calendar : NSCalendar = NSCalendar.current as NSCalendar
        let ageComponents = calendar.components(.year, from: savedBirth, to: now as Date, options: [])
        let age = ageComponents.year!
        
        nameLabel.text = savedName
        personalData.append(Profile(palameter: "Age", value: "\(age)"))
        personalData.append(Profile(palameter: "Gender", value: savedGender))
        personalData.append(Profile(palameter: "Weight", value: "\(savedWeight)"))
        personalData.append(Profile(palameter: "height", value: "\(savedHeight)"))
        personalData.append(Profile(palameter: "ActivityType", value: savedActivity))
        caluculateBmiBmr()
        
    }
    
    @objc func didTapEditBtn(){
        let editVC = EditProfileViewController()
        editVC.delegate = self
        present(editVC, animated: true)
    }
    
    @objc func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    func saveProfile() {
        // UserDefaults
        let defaults = UserDefaults.standard
        let savedName = defaults.object(forKey: "Name") as? String ?? String()
        let savedBirth = defaults.object(forKey: "Birthday") as? Date ?? Date()
        let savedGender = defaults.object(forKey: "Gender") as? String ?? String()
        let savedWeight = defaults.double(forKey: "weight")
        let savedHeight = defaults.double(forKey: "height")
        let savedActivity = defaults.object(forKey: "ActivityType") as? String ?? String()
        
        let now = NSDate()
        let calendar : NSCalendar = NSCalendar.current as NSCalendar
        let ageComponents = calendar.components(.year, from: savedBirth, to: now as Date, options: [])
        let age = ageComponents.year!
        
        personalData.removeAll()
        
        nameLabel.text = savedName
        caluculateBmiBmr()
        
        personalData.append(Profile(palameter: "Age", value: "\(age)"))
        personalData.append(Profile(palameter: "Gender", value: savedGender))
        personalData.append(Profile(palameter: "Weight", value: "\(savedWeight)"))
        personalData.append(Profile(palameter: "height", value: "\(savedHeight)"))
        personalData.append(Profile(palameter: "ActivityType", value: savedActivity))
        
        tableView.reloadData()
    }

    func caluculateBmiBmr() {
        
        // UserDefaults
        let defaults = UserDefaults.standard
        let savedWeight = defaults.double(forKey: "weight")
        let savedHeight = defaults.double(forKey: "height")
        let savedBirth = defaults.object(forKey: "Birthday") as? Date ?? Date()
        let savedGender = defaults.object(forKey: "Gender") as? String ?? String()
        let savedActivity = defaults.object(forKey: "ActivityType") as? String ?? String()
        print(savedActivity)
        
        let now = NSDate()
        let calendar : NSCalendar = NSCalendar.current as NSCalendar
        let ageComponents = calendar.components(.year, from: savedBirth, to: now as Date, options: [])
        let age = Double(ageComponents.year!)
        var bmr = 0.0
        
        /**
         For men: BMR = 10 x weight (kg) + 6.25 x height (cm) – 5 x age (years) + 5
         For women: BMR = 10 x weight (kg) + 6.25 x height (cm) – 5 x age (years) – 161
         */
        
        /** Sedentary (little or no exercise) : Calorie-Calculation = BMR x 1.2
         Lightly active (light exercise/sports 1-3 days/week) : Calorie-Calculation = BMR x 1.375
         Moderately active (moderate exercise/sports 3-5 days/week) : Calorie-Calculation = BMR x 1.55
         Very active (hard exercise/sports 6-7 days a week) : Calorie-Calculation = BMR x 1.725
         If you are extra active (very hard exercise/sports & a physical job) : Calorie-Calculation = BMR x 1.9*/
        
        switch savedGender.lowercased() {
        case "male":
            bmr = 10.0 * savedWeight + 6.25 * (savedHeight * 100) - 5.0 * age + 5.0
        default:
            bmr = 10.0 * savedWeight + 6.25 * (savedHeight * 100) - 5.0 * age - 161.0
        }
        
        let activity = ActivityType(rawValue: savedActivity)
        
        switch activity {
        case .sedentary:
            bmr *= 1.2
        case .lightlyActive:
            bmr *= 1.375
        case .moderatelyActive:
            bmr *= 1.55
        case .veryActive:
            bmr *= 1.725
        case .extraActive:
            bmr *= 1.9
        case .none:
            fatalError()
        }
        
        Profile.bmr = bmr
        bmrValLabel.text = String(Int(bmr)) + " Calories/Day"

        let bmi = savedWeight / (savedHeight * savedHeight)
        bmiValLabel.text =  String(format: "%.2f", bmi)
        
        var classification = ""
        
        switch bmi {
        case 0...18.49:
            classification = "Underweight"
        case 18.50...24.90:
            classification = "Normal"
        case 25.00...30.00:
            classification = "Overweight"
        case 30.00...34.90:
            classification = "Obesity Class 1"
        case 35.00...39.90:
            classification = "Obesity Class 2"
        default:
            classification = "Obesity Class 3"
        }
        cfValLabel.text = classification
        
//        print(classification)
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
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let cell = UITableViewCell(style: .value1, reuseIdentifier: cellId)
        cell.textLabel?.text = personalData[indexPath.row].palameter
        cell.detailTextLabel?.text = personalData[indexPath.row].value
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
}

