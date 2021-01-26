//
//  ProfileViewController.swift
//  Recipe and Calorie Manager
//
//  Created by Kazunobu Someya on 2021-01-19.
//
//  Committed by Chiori Suzuki


import UIKit
import CoreData

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    
    
    // persistantContainer
    private static var persistentContainer: NSPersistentCloudKitContainer! = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer

    // ScrollView
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // profileimage
    let imageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let profileImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "profile.png"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.widthAnchor.constraint(equalToConstant: 100).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return iv
    }()
    let pencilBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 0.5
        button.addTarget(self, action: #selector(setActivityView), for: .touchUpInside)
        return button
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
        tf.layer.borderWidth = 0.8
        tf.layer.cornerRadius = 5
        tf.backgroundColor = .white
        return tf
    }()
    
    let birthPick: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
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
        tf.layer.borderWidth = 0.8
        tf.layer.cornerRadius = 5
        tf.backgroundColor = .white
        return tf
    }()
    let weightSeg: UISegmentedControl = {
        let items = ["kg", "lb"]
        let tf = UISegmentedControl(items: items)
        tf.selectedSegmentIndex = 0
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let heightTxt: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.borderWidth = 0.8
        tf.layer.cornerRadius = 5
        tf.backgroundColor = .white
        return tf
    }()
    let heightSeg: UISegmentedControl = {
        let items = ["cm"]
        let tf = UISegmentedControl(items: items)
        tf.selectedSegmentIndex = 0
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let activeText: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.borderWidth = 0.8
        tf.layer.cornerRadius = 5
        tf.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .touchDown)
        tf.backgroundColor = .white
        return tf
    }()
    let activePick: UIPickerView = {
        let dp = UIPickerView()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.isHidden = true
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
    
    // submitButton
    let submitBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(addNewPerson), for: .touchUpInside)
//        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "Register Your Profile"
        
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(scrollView)
        scrollView.addSubview(mainSV)
        setSVConfig()
        
        activePick.delegate = self
        activePick.dataSource = self
        
        activeText.delegate = self
        
        registerForKeyboardNotification()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(gestureRecognizer)
        
        scrollView.delegate = self
        

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
        
        mainSV.addArrangedSubview(imageView)
        mainSV.addArrangedSubview(nameSV)
        mainSV.addArrangedSubview(birthSV)
        mainSV.addArrangedSubview(genderSV)
        mainSV.addArrangedSubview(weightSV)
        mainSV.addArrangedSubview(heightSV)
        mainSV.addArrangedSubview(activeSV)
        mainSV.addArrangedSubview(activePick)
        mainSV.addArrangedSubview(submitBtn)
        mainSV.axis = .vertical
        mainSV.alignment = .fill
        mainSV.distribution = .equalSpacing
        mainSV.spacing = 30
        
        /* imageView ********/
        imageView.addSubview(profileImage)
        imageView.addSubview(pencilBtn)
        profileImage.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 20).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
        profileImage.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        pencilBtn.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 5).isActive = true
        pencilBtn.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 5).isActive = true
        
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
        weightSV.addArrangedSubview(weightSeg)
        weightSV.axis = .horizontal
        weightSV.alignment = .fill
        weightSV.spacing = 10
        
        /* heightSV *********/
        heightSV.addArrangedSubview(heightLabel)
        heightSV.addArrangedSubview(heightTxt)
        heightSV.addArrangedSubview(heightSeg)
        heightSV.axis = .horizontal
        heightSV.alignment = .fill
        heightSV.spacing = 10
        
        /* activitySV *********/
        activeSV.addArrangedSubview(activeLabel)
        activeSV.addArrangedSubview(activeText)
        activeSV.axis = .horizontal
        activeSV.alignment = .fill
        activeSV.spacing = 10
        
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        activePick.isHidden = false
    }
    
    @objc func setActivityView() {
        guard let image = profileImage.image else { return }
        let activitiController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activitiController, animated: true, completion: nil)
    }
    

    static func newPersion() -> Person {
        let context = persistentContainer.viewContext
        let person = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context) as! Person
        return person
    }
    
    @objc func addNewPerson1() {
        let person = ProfileViewController.newPersion()
        let dateFormater: DateFormatter = DateFormatter()
        dateFormater.dateFormat = "MM/dd/yyyy"
        let stringFromDate: String = dateFormater.string(from: self.birthPick.date) as String
        let birthDate: Date = dateFormater.date(from: stringFromDate)!
        
//        print("\(nameTxt.text), \(genderSeg.titleForSegment(at: genderSeg.selectedSegmentIndex)), \(activeText.text)")
        person.name = nameTxt.text
        person.birthday = birthDate
        person.gender = genderSeg.titleForSegment(at: genderSeg.selectedSegmentIndex)
        guard let weight = Double(weightTxt.text!), let height = Double(heightTxt.text!) else { return }
        person.weight = weight
        person.height = height
        person.activityType = activeText.text
        
    }
    
    // saving Personal Data
    @objc func addNewPerson() {
        
        let dateFormater: DateFormatter = DateFormatter()
        dateFormater.dateStyle = .short
        dateFormater.timeStyle = .none
//        dateFormater.dateFormat = "MM/dd/yyyy"
        
        let stringFromDate: String = dateFormater.string(from: self.birthPick.date) as String
        let birthDate: Date = dateFormater.date(from: stringFromDate)!
        
        guard let weight = Double(weightTxt.text!), let height = Double(heightTxt.text!) else { return }
        
        
        
        // UserDefaults
        let defaults = UserDefaults.standard
        print(defaults)
        print(defaults.object(forKey: "Name") as? String ?? String())
        
        defaults.set(nameTxt.text, forKey: "Name")
        defaults.set(birthDate, forKey: "Birthday")
        defaults.set(genderSeg.titleForSegment(at: genderSeg.selectedSegmentIndex), forKey: "Gender")
        defaults.set(weight, forKey: "weight")
        defaults.set(height, forKey: "height")
        defaults.set(activeText.text, forKey: "ActivityType")
        
        
//        let savedName = defaults.object(forKey: "Name") as? String ?? String()
//        var savedBirth = defaults.object(forKey: "Birthday") as? Date ?? Date()
//        let savedGender = defaults.object(forKey: "Gender") as? String ?? String()
//        let savedWeight = defaults.double(forKey: "weight")
//        let savedHeight = defaults.double(forKey: "height")
//        let savedActivity = defaults.object(forKey: "ActivityType") as? String ?? String()

//        print(stringFromDate)
//        print(birthDate)
//        savedBirth = dateFormater.date(from: stringFromDate)!
//        print(savedName)
//        print(savedBirth)
//        print(savedGender)
//        print(savedWeight)
//        print(savedHeight)
//        print(savedActivity)
    }
    
    
    static func save() {
        ProfileViewController.persistentContainer.saveContext()
    }
    
    // scrollView
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
      view.endEditing(true)
    }
    
    fileprivate func registerForKeyboardNotification() {
      // 1. I want to listen to the keyboard showing / hiding
      //    - "hey iOS, tell(notify) me when keyboard shows / hides"
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(_ notification: NSNotification) {
      // 2. When notified, I want to ask iOS the size(height) of the keyboard
      guard let info = notification.userInfo, let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
      
      let keyboardFrame = keyboardFrameValue.cgRectValue
      let keyboardHeight = keyboardFrame.size.height
      
      // 3. Tell scrollview to scroll up (height)
      let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 100)
      scrollView.contentInset = insets
      scrollView.scrollIndicatorInsets = insets
    }

    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
      // 2. When notified, I want to ask iOS the size(height) of the keyboard
      // 3. Tell scrollview to scroll down (height)
      let insets = UIEdgeInsets.zero
      scrollView.contentInset = insets
      scrollView.scrollIndicatorInsets = insets
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeText.text = activityItems[row]
        UIView.animate(withDuration: 0.3) {
            pickerView.isHidden = true
        }
    }
}

extension ProfileViewController: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return nil
  }
}
