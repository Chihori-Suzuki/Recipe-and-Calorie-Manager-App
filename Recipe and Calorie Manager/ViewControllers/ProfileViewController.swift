//
//  ProfileViewController.swift
//  Recipe and Calorie Manager
//
//  Created by Kazunobu Someya on 2021-01-19.
//
//  Committed by Chiori Suzuki


import UIKit

class ProfileViewController: UIViewController {

    private let imageView = UIImageView()
    
    // imageView
    let profileImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "Profile"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    // Label Field
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.setContentHuggingPriority(.required, for: .horizontal)
        lb.text = "Name"
        return lb
        }()
    let birthLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.setContentHuggingPriority(.required, for: .horizontal)
        lb.text = "Birthday"
        return lb
        }()
    let genderLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.setContentHuggingPriority(.required, for: .horizontal)
        lb.text = "Gender"
        return lb
    }()
    let weightLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.setContentHuggingPriority(.required, for: .horizontal)
        lb.text = "Weight"
        return lb
    }()
    let heightLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.setContentHuggingPriority(.required, for: .horizontal)
        lb.text = "Height"
        return lb
    }()
    let activeLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.setContentHuggingPriority(.required, for: .horizontal)
        lb.text = "Activity Type"
        return lb
    }()
    
    // Text,  Field
    let nameTxt: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .line
        return tf
    }()
    
    let birthPick: UIDatePicker = {
       let dp = UIDatePicker()
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    let genderSeg: UISegmentedControl = {
        let items = ["male", "female"]
        let tf = UISegmentedControl(items: items)
        tf.selectedSegmentIndex = 0
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    let weightTxt: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .line
        return tf
    }()
    let heightTxt: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .line
        return tf
    }()
    let activePick: UIPickerView = {
        let dp = UIPickerView()
         dp.translatesAutoresizingMaskIntoConstraints = false
         return dp
     }()
    
    let activityItems = ["item1", "item2", "item3"]
    
    // StackView Field
    let mainSV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let nameSV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let birthSV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let genderSV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let weightSV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let heightSV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let activeSV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(mainSV)
        
        setSVConfig()
        
        activePick.delegate = self
        activePick.dataSource = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func setSVConfig() {
        /* mainSV **********/
        mainSV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        mainSV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        mainSV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        mainSV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 30).isActive = true
        
        mainSV.addArrangedSubview(imageView)
        mainSV.addArrangedSubview(nameSV)
        mainSV.addArrangedSubview(birthSV)
        mainSV.addArrangedSubview(genderSV)
        mainSV.addArrangedSubview(weightSV)
        mainSV.addArrangedSubview(heightSV)
        mainSV.addArrangedSubview(activeSV)
        mainSV.axis = .vertical
        mainSV.alignment = .fill
        mainSV.distribution = .equalSpacing
        mainSV.spacing = 30
        
        
        /* nameSV **********/
        nameSV.addArrangedSubview(nameLabel)
        nameSV.addArrangedSubview(nameTxt)
        nameSV.axis = .horizontal
        nameSV.alignment = .fill
        nameSV.spacing = 10
        
        /* birthSV **********/
        birthSV.addArrangedSubview(birthLabel)
        birthSV.addArrangedSubview(birthPick)
        birthSV.axis = .horizontal
        birthSV.alignment = .fill
        birthSV.spacing = 10
        
        /* genderSV **********/
        genderSV.addArrangedSubview(genderLabel)
        genderSV.addArrangedSubview(genderSeg)
        genderSV.axis = .horizontal
        genderSV.alignment = .fill
        genderSV.spacing = 10
        
        /* weightSV *********/
        weightSV.addArrangedSubview(weightLabel)
        weightSV.addArrangedSubview(weightTxt)
        weightSV.axis = .horizontal
        weightSV.alignment = .fill
        weightSV.spacing = 10
        
        /* heightSV *********/
        heightSV.addArrangedSubview(heightLabel)
        heightSV.addArrangedSubview(heightTxt)
        heightSV.axis = .horizontal
        heightSV.alignment = .fill
        heightSV.spacing = 10
        
        /* activitySV *********/
        activeSV.addArrangedSubview(activeLabel)
        activeSV.addArrangedSubview(activePick)
        activeSV.axis = .horizontal
        activeSV.alignment = .fill
        activeSV.spacing = 10
        
    }

}

extension ProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activityItems.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activityItems[row]
    }
    
    
    
    
}
