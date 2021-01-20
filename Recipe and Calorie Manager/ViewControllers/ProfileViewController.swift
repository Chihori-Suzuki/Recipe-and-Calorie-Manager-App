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
    
    // Label Field
    let nameLabel: UILabel = {
            let lb = UILabel()
            lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Name"
            return lb
        }()
    let birthLabel: UILabel = {
            let lb = UILabel()
            lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Name"
            return lb
        }()
    let genderLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
    lb.text = "Gender"
        return lb
    }()
    let weightLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
    lb.text = "Weight"
        return lb
    }()
    let heightLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
    lb.text = "Height"
        return lb
    }()
    let activityLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
    lb.text = "Activity Type"
        return lb
    }()
    
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
    let activitySV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
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
        let tf = UISegmentedControl()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let weightPick: UIPickerView = {
        let dp = UIPickerView()
         dp.translatesAutoresizingMaskIntoConstraints = false
         return dp
     }()
    let heightPick: UIPickerView = {
        let dp = UIPickerView()
         dp.translatesAutoresizingMaskIntoConstraints = false
         return dp
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(mainSV)
        
        setSVConfig()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func setSVConfig() {
        /* mainSV **********/
        mainSV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        mainSV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        mainSV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        mainSV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        mainSV.axis = .vertical
        mainSV.alignment = .fill
        mainSV.distribution = .equalSpacing
        
        mainSV.addArrangedSubview(nameSV)
        mainSV.addArrangedSubview(birthSV)
        mainSV.addArrangedSubview(weightSV)
        mainSV.addArrangedSubview(heightSV)
        mainSV.addArrangedSubview(activitySV)
        
        /* nameSV **********/
        nameSV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        nameSV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        nameSV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        nameSV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        nameSV.axis = .horizontal
        nameSV.alignment = .fill
        nameSV.distribution = .equalSpacing
        nameSV.addArrangedSubview(nameLabel)
        nameSV.addArrangedSubview(nameTxt)
        
        
        /* birthSV **********/
//        birthSV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
//        birthSV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
//        birthSV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
//        birthSV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
//
//        birthSV.axis = .horizontal
//        birthSV.alignment = .fill
//        birthSV.distribution = .equalSpacing
//        birthSV.addArrangedSubview(genderLabel)
//        birthSV.addArrangedSubview(genderPick)
        
        /**/
        
        
        
    }
    

}
