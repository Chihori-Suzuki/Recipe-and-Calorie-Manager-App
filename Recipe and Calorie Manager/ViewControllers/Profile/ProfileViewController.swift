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
    // persistentContainer
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
    var profileImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "profile_male.png"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.layer.masksToBounds = false
        iv.layer.cornerRadius = iv.frame.height/2
        iv.clipsToBounds = true
        iv.widthAnchor.constraint(equalToConstant: 250).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 250).isActive = true
        return iv
    }()
    let pencilBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.backgroundColor = .white
        button.widthAnchor.constraint(equalToConstant: 28).isActive = true
        button.heightAnchor.constraint(equalToConstant: 28).isActive = true
        button.layer.borderWidth = 0.3
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(setActivityView), for: .touchUpInside)
        return button
    }()
    //Labels
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "ArialRoundedMTBold", size: 21)
        lb.textColor = UIColor.Theme1.black
        lb.setContentHuggingPriority(.required, for: .horizontal)
        lb.text = "Name"
        return lb
    }()
    let birthLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "ArialRoundedMTBold", size: 21)
        lb.textColor = UIColor.Theme1.black
        lb.setContentHuggingPriority(.required, for: .horizontal)
        lb.text = "Birthday"
        return lb
    }()
    let weightLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "ArialRoundedMTBold", size: 21)
        lb.textColor = UIColor.Theme1.black
        lb.setContentHuggingPriority(.required, for: .horizontal)
        lb.text = "Weight"
        return lb
    }()
    let heightLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "ArialRoundedMTBold", size: 21)
        lb.textColor = UIColor.Theme1.black
        lb.setContentHuggingPriority(.required, for: .horizontal)
        lb.text = "Height"
        return lb
    }()
    let activeLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "ArialRoundedMTBold", size: 21)
        lb.textColor = UIColor.Theme1.black
        lb.setContentHuggingPriority(.required, for: .horizontal)
        lb.text = "Activity Type"
        return lb
    }()
    //Textfields
    let nameTxt: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.Theme1.brown
        tf.font = .systemFont(ofSize: 20)
        tf.layer.cornerRadius = 8
        tf.backgroundColor = .white
        return tf
    }()
    let weightTxt: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.Theme1.brown
        tf.layer.cornerRadius = 8
        tf.font = .systemFont(ofSize: 20)
        tf.backgroundColor = .white
        return tf
    }()
    let heightTxt: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 8
        tf.textColor = UIColor.Theme1.brown
        tf.font = .systemFont(ofSize: 20)
        tf.backgroundColor = .white
        return tf
    }()
    let activeText: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 8
        tf.textColor = UIColor.Theme1.brown
        tf.isHidden = true
        tf.font = .systemFont(ofSize: 20)
        tf.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .touchDown)
        tf.backgroundColor = .white
        return tf
    }()
    let birthPick: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        return dp
    }()
    let genderSeg: UISegmentedControl = {
        let items = [Gender.male.rawValue, Gender.female.rawValue]
        let tf = UISegmentedControl(items: items)
        tf.selectedSegmentIndex = 0
        tf.layer.cornerRadius = 12
        let font = UIFont.systemFont(ofSize: 20)
        tf.setTitleTextAttributes([NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.Theme1.black], for: .normal)
        tf.addTarget(self, action: #selector(genderChanged(_:)), for: .allEvents)
        return tf
    }()
    let weightSeg: UISegmentedControl = {
        let items = ["kg", "lb"]
        let tf = UISegmentedControl(items: items)
        tf.selectedSegmentIndex = 0
        let font = UIFont.systemFont(ofSize: 20)
        tf.setTitleTextAttributes([NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.Theme1.black], for: .normal)
        return tf
    }()
    let heightSeg: UISegmentedControl = {
        let items = ["cm", "m"]
        let tf = UISegmentedControl(items: items)
        tf.selectedSegmentIndex = 0
        let font = UIFont.systemFont(ofSize: 20)
        tf.setTitleTextAttributes([NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.Theme1.black], for: .normal)
        return tf
    }()
    let activePick: UIPickerView = {
        let dp = UIPickerView()
        dp.clipsToBounds = true
        return dp
    }()
    
    let activityItems = ActivityType.allCases
    // StackView Field
    let nameSV = UIStackView()
    let birthSV = UIStackView()
    let weightSV = UIStackView()
    let heightSV = UIStackView()
    let activeSV = UIStackView()
    let mainSV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    // submitButton
    let saveBtn: UIButton = {
        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.widthAnchor.constraint(equalToConstant: 90).isActive = true
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.backgroundColor = UIColor.Theme1.green
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(addNewPerson), for: .touchUpInside)
        button.alpha = 0.8
        return button
    }()
    
    @objc func genderChanged(_ sender: UISegmentedControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            switch sender.selectedSegmentIndex {
            case 0: self.profileImage.image = UIImage(named: "profile_male.png")
            default: self.profileImage.image = UIImage(named: "profile_female.png")
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Theme1.blue, NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 30)!]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9697935916, blue: 0.7963718291, alpha: 1)
        title = "Register Your Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(scrollView)
        scrollView.addSubview(mainSV)
        setSVConfig()
        registerForKeyboardNotification()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(gestureRecognizer)
        activePick.delegate = self
        activePick.dataSource = self
        activeText.delegate = self
        scrollView.delegate = self
    }
    func setSVConfig() {
        /* scrollView **********/
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        /* mainSV **********/
        mainSV.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        mainSV.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor).isActive = true
        mainSV.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor).isActive = true
        mainSV.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        mainSV.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
        
        let sv = UIStackView(arrangedSubviews: [UIView(), saveBtn, UIView()])
        sv.axis = .horizontal
        sv.distribution = .equalCentering
        sv.alignment = .center
        mainSV.addArrangedSubview(imageView)
        mainSV.addArrangedSubview(nameSV)
        mainSV.addArrangedSubview(birthSV)
        mainSV.addArrangedSubview(weightSV)
        mainSV.addArrangedSubview(heightSV)
        mainSV.addArrangedSubview(activeSV)
//        mainSV.addArrangedSubview(activePick)
        mainSV.addArrangedSubview(UIView())
        mainSV.addArrangedSubview(sv)
        mainSV.axis = .vertical
        mainSV.alignment = .fill
        mainSV.distribution = .fill
        mainSV.spacing = 18
        
        /* imageView ********/
        imageView.addSubview(profileImage)
        imageView.addSubview(pencilBtn)
        profileImage.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 20).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
        profileImage.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        pencilBtn.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: -3).isActive = true
        pencilBtn.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: -13).isActive = true
        /* nameSV **********/
        nameSV.addArrangedSubview(nameLabel)
        nameSV.addArrangedSubview(nameTxt)
        nameTxt.heightAnchor.constraint(equalToConstant: birthPick.bounds.size.height).isActive = true
        nameSV.axis = .horizontal
        nameSV.alignment = .fill
        nameSV.spacing = 10
        /* birthSV **********/
        birthSV.addArrangedSubview(birthLabel)
        birthSV.addArrangedSubview(birthPick)
        genderSeg.heightAnchor.constraint(equalToConstant: birthPick.bounds.size.height).isActive = true
        birthSV.addArrangedSubview(genderSeg)
        birthSV.axis = .horizontal
        birthSV.alignment = .fill
        birthSV.distribution = .fill
        birthSV.spacing = 8
        /* weightSV *********/
        weightSV.addArrangedSubview(weightLabel)
        weightSV.addArrangedSubview(weightTxt)
        weightSV.addArrangedSubview(weightSeg)
        weightTxt.heightAnchor.constraint(equalToConstant: birthPick.bounds.size.height).isActive = true
        weightSeg.heightAnchor.constraint(equalToConstant: birthPick.bounds.size.height).isActive = true
        weightSeg.widthAnchor.constraint(equalToConstant: genderSeg.bounds.size.width).isActive = true
        weightSV.axis = .horizontal
        weightSV.alignment = .fill
        weightSV.spacing = 8
        /* heightSV *********/
        heightSV.addArrangedSubview(heightLabel)
        heightSV.addArrangedSubview(heightTxt)
        heightSV.addArrangedSubview(heightSeg)
        heightTxt.heightAnchor.constraint(equalToConstant: birthPick.bounds.size.height).isActive = true
        heightSeg.heightAnchor.constraint(equalToConstant: birthPick.bounds.size.height).isActive = true
        heightSeg.widthAnchor.constraint(equalToConstant: genderSeg.bounds.size.width).isActive = true
        heightSV.axis = .horizontal
        heightSV.alignment = .fill
        heightSV.spacing = 10
        /* activitySV *********/
        activeSV.addArrangedSubview(activeLabel)
        activeSV.addArrangedSubview(activePick)
        activeSV.addArrangedSubview(activeText)
        activeText.heightAnchor.constraint(equalToConstant: birthPick.bounds.size.height).isActive = true
        activeSV.axis = .horizontal
        activeSV.alignment = .fill
        activeSV.distribution = .fill
        activeSV.spacing = 10
    }
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        activePick.isHidden = false
        activeText.isHidden = true
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
    // saving Personal Data
    @objc func addNewPerson() {
        
        let dateFormater: DateFormatter = DateFormatter()
        dateFormater.dateStyle = .short
        dateFormater.timeStyle = .none
        let stringFromDate: String = dateFormater.string(from: self.birthPick.date) as String
        let birthDate: Date = dateFormater.date(from: stringFromDate)!
        
        guard let weight = Double(weightTxt.text!), let height = Double(heightTxt.text!) else {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.05
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: saveBtn.center.x - 12, y: saveBtn.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: saveBtn.center.x + 12, y: saveBtn.center.y))
            saveBtn.layer.add(animation, forKey: "position")
            return
        }
        // UserDefaults
        let defaults = UserDefaults.standard
        defaults.set(nameTxt.text, forKey: "Name")
        defaults.set(birthDate, forKey: "Birthday")
        defaults.set(genderSeg.titleForSegment(at: genderSeg.selectedSegmentIndex), forKey: "Gender")
        defaults.set(activeText.text, forKey: "ActivityType")
        defaults.set(weight, forKey: "weight")
        defaults.set(height, forKey: "height")
        
        switch weightSeg.selectedSegmentIndex {
        case 0: defaults.set(Weight.kilogram.rawValue, forKey: "weightUnit")
        default: defaults.set(Weight.pound.rawValue, forKey: "weightUnit")
        }
        switch heightSeg.selectedSegmentIndex {
        case 0: defaults.set(Height.centimeter.rawValue, forKey: "heightUnit")
        default: defaults.set(Height.meter.rawValue, forKey: "heightUnit")
        }
        
        UIView.animate(withDuration: 0.10) {
            self.saveBtn.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        } completion: { (_) in
            UIView.animate(withDuration: 0.10) {
                self.saveBtn.transform = CGAffineTransform.identity
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let showVC = showProfileViewController()
            self.navigationController?.pushViewController(showVC, animated: true)
        }
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
        guard let info = notification.userInfo, let keyboardFrameValue = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardHeight = keyboardFrame.size.height
        
        // 3. Tell scrollview to scroll up (height)
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight + 60, right: 0)
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
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.systemFont(ofSize: 18)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = activityItems[row].rawValue
        pickerLabel?.textColor = UIColor.Theme1.blue

        return pickerLabel!
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activityItems.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activityItems[row].rawValue
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeText.text = activityItems[row].rawValue
        activeText.isHidden.toggle()
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
