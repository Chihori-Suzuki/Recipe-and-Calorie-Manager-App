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
        let savedGender = UserDefaults.standard.object(forKey: "Gender") as? String ?? String()
        let gender = Gender(rawValue: savedGender)
        let iv = UIImageView(image: UIImage(named: "profile_\(gender?.rawValue ?? "male")"))
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = false
        iv.layer.cornerRadius = iv.frame.height/2
        iv.clipsToBounds = true
        iv.widthAnchor.constraint(equalToConstant: 120).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 120).isActive = true
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
    let cfSV = UIStackView()
    let idealWeightSV = UIStackView()
    // Label
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "ArialRoundedMTBold", size: 22)
        lb.adjustsFontSizeToFitWidth = true
        lb.textColor = UIColor.Theme1.blue
        return lb
    }()
    let bmrLabel: UILabel = {
        let lb = UILabel()
        lb.text = "BMR"
        lb.setContentHuggingPriority(.required, for: .horizontal)
        lb.font = UIFont(name: "ArialRoundedMTBold", size: 17)
        lb.adjustsFontSizeToFitWidth = true
        lb.textColor = UIColor.Theme1.black
        return lb
    }()
    let bmrValLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.textAlignment = .right
        lb.textColor = UIColor.Theme1.green
        return lb
    }()
    let bmiLabel: UILabel = {
        let lb = UILabel()
        lb.text = "BMI"
        lb.font = UIFont(name: "ArialRoundedMTBold", size: 17)
        lb.textColor = UIColor.Theme1.black
        lb.adjustsFontSizeToFitWidth = true
        return lb
    }()
    let bmiValLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.Theme1.green
        lb.setContentHuggingPriority(.required, for: .horizontal)
        return lb
    }()
    let cfLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "ArialRoundedMTBold", size: 17)
        lb.textColor = UIColor.Theme1.black
        lb.adjustsFontSizeToFitWidth = true
        lb.text = "Type"
        return lb
    }()
    let cfValLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.Theme1.green
        lb.textAlignment = .right
        return lb
    }()
    let idealWeightLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "ArialRoundedMTBold", size: 17)
        lb.textColor = UIColor.Theme1.black
        lb.numberOfLines = 0
        lb.text = "Weight Goal"
        return lb
    }()
    let idealWeightValueLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .right
        lb.numberOfLines = 0
        lb.textColor = UIColor.Theme1.green
        return lb
    }()
    // tableView
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.layer.cornerRadius = 16
        tv.clipsToBounds = true
        return tv
    }()
    let cellId = "cellId"
    var sectionTitle: [String] = ["Statistics"]
    var personalData = [Profile]()
    let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.widthAnchor.constraint(equalToConstant: 90).isActive = true
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.backgroundColor = UIColor.Theme1.green
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didTapEditBtn), for: .touchUpInside)
        button.alpha = 0.8
        return button
    }()
    override func viewWillAppear(_ animated: Bool) {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Theme1.blue, NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 30)!]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = tabBarController?.tabBar.standardAppearance
       appearance?.shadowImage = nil
       appearance?.shadowColor = nil
       appearance?.backgroundColor = UIColor.Theme1.white
       guard let style = appearance else { return }
       tabBarController?.tabBar.standardAppearance = style
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
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        /* mainSV **********/
        mainSV.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        mainSV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        mainSV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        mainSV.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        
        /* bmrSV **********/
        bmrSV.addArrangedSubview(bmrLabel)
        bmrSV.addArrangedSubview(bmrValLabel)
        bmrSV.axis = .horizontal
        bmrSV.alignment = .fill
        bmrSV.distribution = .fill
        bmrSV.spacing = 10
        /* bmiSV **********/
        bmiSV.addArrangedSubview(bmiLabel)
        bmiSV.addArrangedSubview(bmiValLabel)
        bmiSV.axis = .horizontal
        bmiSV.alignment = .fill
        bmiSV.distribution = .fill
        bmiSV.spacing = 10
        /* cfSV **********/
        cfSV.addArrangedSubview(cfLabel)
        cfSV.addArrangedSubview(cfValLabel)
        cfSV.axis = .horizontal
        cfSV.alignment = .fill
        cfSV.distribution = .fill
        cfSV.spacing = 10
        /* idealWeightSV **********/
        idealWeightSV.addArrangedSubview(idealWeightLabel)
        idealWeightSV.addArrangedSubview(idealWeightValueLabel)
        idealWeightSV.axis = .horizontal
        idealWeightSV.alignment = .fill
        idealWeightSV.distribution = .fill
        idealWeightSV.spacing = 0
        /* nameSV **********/
        nameSV.addArrangedSubview(nameLabel)
        nameSV.addArrangedSubview(bmrSV)
        nameSV.addArrangedSubview(bmiSV)
        nameSV.addArrangedSubview(cfSV)
        nameSV.addArrangedSubview(idealWeightSV)
        nameSV.axis = .vertical
        nameSV.alignment = .fill
        nameSV.distribution = .fillProportionally
        nameSV.spacing = 8
        /* headSV **********/
        headSV.addArrangedSubview(profileImage)
        headSV.addArrangedSubview(nameSV)
        headSV.axis = .horizontal
        headSV.alignment = .fill
        headSV.distribution = .fillProportionally
        headSV.heightAnchor.constraint(equalToConstant: 140).isActive = true
        headSV.spacing = 8
        let sv = UIStackView(arrangedSubviews: [UIView(), editButton, UIView()])
        sv.axis = .horizontal
        sv.distribution = .equalCentering
        sv.alignment = .center
        //mainSV
        mainSV.addArrangedSubview(headSV)
        mainSV.addArrangedSubview(tableView)
        mainSV.addArrangedSubview(sv)
        mainSV.axis = .vertical
        mainSV.alignment = .fill
        mainSV.distribution = .fill
        mainSV.spacing = 50
        
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.31).isActive = true
        tableView.backgroundColor = UIColor.Theme1.white
        tableView.layer.cornerRadius = 12
        tableView.separatorStyle = .none
    }
    
    // get image by url
    func getImageByUrl(url: String) -> UIImage{
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            return UIImage(data: data)!
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        return UIImage()
    }
    

    func setPersonalData(){
        // UserDefaults
        let defaults = UserDefaults.standard
        let savedImageURL = defaults.object(forKey: "Image") as? String ?? String()
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
        
//        print(savedImageURL)
//        let savedImagee = UIImage(contentsOfFile: savedImageURL)
        let savedImage: UIImage = getImageByUrl(url: savedImageURL)
        profileImage.image = savedImage
        nameLabel.text = savedName
        personalData.append(Profile(parameter: "Age", value: "\(age)"))
        personalData.append(Profile(parameter: "Gender", value: savedGender))
        personalData.append(Profile(parameter: "Weight", value: "\(savedWeight)"))
        personalData.append(Profile(parameter: "Height", value: "\(savedHeight)"))
        personalData.append(Profile(parameter: "Activity Type", value: savedActivity))
        calculateBmiBmr()
        calculateIdealWeight()
    }
    
    private func calculateIdealWeight() {
        var savedHeight = UserDefaults.standard.double(forKey: "height")
        let savedHeightUnit = UserDefaults.standard.double(forKey: "heightUnit")
        let heightUnit = Height(rawValue: savedHeightUnit)
        
        heightUnit == Height.meter ? (savedHeight = savedHeight * 39.3701) : (savedHeight = savedHeight * 0.393701)
        
//        (58″) 91 to 115 lbs
//        (59″) 94 to 119 lbs
//        (60″) 97 to 123 lbs
//        (61″) 100 to 127 lbs
//        (62″) 104 to 131 lbs
//        (63″) 107 to 135 lbs
//        (64″) 110 to 140 lbs
//        (65″) 114 to 144 lbs
//        (66″) 118 to 148 lbs
//        (67″) 121 to 153 lbs
//        (68″) 125 to 158 lbs
//        (69″) 128 to 162 lbs
//        (70″) 132 to 167 lbs
//        (71″) 136 to 172 lbs
//        (72″) 140 to 177 lbs
//        (73″) 144 to 182 lbs
//        (74″) 148 to 186 lbs
//        (75″) 152 to 192 lbs
//        (76″) 156 to 197 lbs
        let height = Int(savedHeight)
        let weight = ["91-115 lbs",
                      "94-119 lbs",
                      "97-123 lbs",
                      "100-127 lbs",
                      "104-131 lbs",
                      "107-135 lbs",
                      "110-140 lbs",
                      "114-144 lbs",
                      "118-148 lbs",
                      "121-153 lbs",
                      "125-158 lbs",
                      "128-162 lbs",
                      "132-167 lbs",
                      "136-172 lbs",
                      "140-177 lbs",
                      "144-182 lbs",
                      "148-186 lbs",
                      "152-192 lbs",
                      "156-197 lbs"]
        var index = 0
        for counter in 58...76 {
            if height == counter {
                idealWeightValueLabel.text = weight[index]
            }
            index += 1
        }
    }
    
    @objc func didTapEditBtn(){
        UIView.animate(withDuration: 0.10) {
            self.editButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        } completion: { (_) in
            UIView.animate(withDuration: 0.10) {
                self.editButton.transform = CGAffineTransform.identity
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let editVC = EditProfileViewController()
            editVC.delegate = self
            self.present(editVC, animated: true)
        }
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
        calculateBmiBmr()
        calculateIdealWeight()
        
        personalData.append(Profile(parameter: "Age", value: "\(age)"))
        personalData.append(Profile(parameter: "Gender", value: savedGender))
        personalData.append(Profile(parameter: "Weight", value: "\(savedWeight)"))
        personalData.append(Profile(parameter: "Height", value: "\(savedHeight)"))
        personalData.append(Profile(parameter: "Activity Type", value: savedActivity))
        
        tableView.reloadData()
    }

    func calculateBmiBmr() {
        // UserDefaults
        let defaults = UserDefaults.standard
        var savedWeight = defaults.double(forKey: "weight")
        var savedHeight = defaults.double(forKey: "height")
        let savedBirth = defaults.object(forKey: "Birthday") as? Date ?? Date()
        let savedGender = defaults.object(forKey: "Gender") as? String ?? String()
        let savedActivity = defaults.object(forKey: "ActivityType") as? String ?? String()
        
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
        
        let savedWeightUnit = UserDefaults.standard.double(forKey: "weightUnit")
        let weightUnit = Weight(rawValue: savedWeightUnit)
        let savedHeightUnit = UserDefaults.standard.double(forKey: "heightUnit")
        let heightUnit = Height(rawValue: savedHeightUnit)
        
        weightUnit == Weight.pound ? (savedWeight = savedWeight / 2.20462) : nil
        heightUnit == Height.meter ? (savedHeight = savedHeight * 100) : nil
  
        switch savedGender.lowercased() {
        case "male":
            bmr = 10.0 * savedWeight + 6.25 * savedHeight - 5.0 * age + 5.0
        default:
            bmr = 10.0 * savedWeight + 6.25 * savedHeight - 5.0 * age - 161.0
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
        
//      BMI = weight (kg) / (height * height (meters))
        savedHeight = savedHeight / 100
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
            classification = "Obesity 1"
        case 35.00...39.90:
            classification = "Obesity 2"
        default:
            classification = "Obesity 3"
        }
        cfValLabel.text = classification
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
        cell.textLabel?.text = personalData[indexPath.row].parameter
        cell.detailTextLabel?.text = personalData[indexPath.row].value
        cell.backgroundColor = #colorLiteral(red: 1, green: 0.9697935916, blue: 0.7963718291, alpha: 1)
        cell.textLabel?.textColor = UIColor.Theme1.black
        cell.detailTextLabel?.textColor = UIColor.Theme1.black
        cell.textLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 18, weight: .light)
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: .zero, y: .zero, width: tableView.frame.width, height: 35)
        myLabel.font = UIFont.boldSystemFont(ofSize: 22)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        myLabel.textColor = UIColor.Theme1.blue
        myLabel.layer.cornerRadius = 12
        
        let headerView = UIView()
        headerView.addSubview(myLabel)
        myLabel.contentMode = .scaleAspectFit
        
        return headerView
    }
}
