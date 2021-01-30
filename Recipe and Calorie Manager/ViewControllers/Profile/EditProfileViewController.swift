//
//  EditProfileViewController.swift
//  Recipe and Calorie Manager
//
//  Created by 鈴木ちほり on 2021/01/25.
//

import UIKit

protocol EditProfileDelegate: class {
    func saveProfile()
}

class EditProfileViewController: UIViewController, UITextFieldDelegate {
    // ScrollView
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    // profileimage
    let imageView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 250).isActive = true
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let profileImage: UIImageView = {
        let savedGender = UserDefaults.standard.object(forKey: "Gender") as? String ?? String()
        let gender = Gender(rawValue: savedGender)
        let iv = UIImageView(image: UIImage(named: "profile_\(gender?.rawValue ?? "male")"))
        iv.contentMode = .scaleAspectFit
        iv.layer.masksToBounds = false
        iv.layer.cornerRadius = iv.frame.height/2
        iv.clipsToBounds = true
        iv.widthAnchor.constraint(equalToConstant: 250).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 250).isActive = true
        iv.translatesAutoresizingMaskIntoConstraints = true
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
        button.addTarget(self, action: #selector(selectPicture), for: .touchUpInside)
        return button
    }()
    // UserDefaults
    let defaults = UserDefaults.standard
    // Label Field
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "ArialRoundedMTBold", size: 21)
        lb.textColor = UIColor.Theme1.black
        lb.setContentHuggingPriority(.required, for: .horizontal)
        lb.text = "Name"
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
    // Text,  Field
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
        tf.font = .systemFont(ofSize: 20)
        tf.layer.cornerRadius = 8
        tf.backgroundColor = .white
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
    let heightTxt: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.Theme1.brown
        tf.font = .systemFont(ofSize: 20)
        tf.layer.cornerRadius = 8
        tf.backgroundColor = .white
        return tf
    }()
    let heightSeg: UISegmentedControl = {
        let items = ["cm", "m"]
        let tf = UISegmentedControl(items: items)
        tf.selectedSegmentIndex = 0
        tf.layer.cornerRadius = 12
        let font = UIFont.systemFont(ofSize: 20)
        tf.setTitleTextAttributes([NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.Theme1.black], for: .normal)
        return tf
    }()
    let activeText: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.Theme1.brown
        tf.font = .systemFont(ofSize: 20)
        tf.layer.cornerRadius = 8
        tf.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .touchDown)
        tf.backgroundColor = UIColor.Theme1.white
        return tf
    }()
    let activePick: UIPickerView = {
        let dp = UIPickerView()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.isHidden = true
        return dp
    }()
    
    let activityItems = ActivityType.allCases

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
    //submit button
    let submitBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.widthAnchor.constraint(equalToConstant: 90).isActive = true
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.backgroundColor = UIColor.Theme1.green
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        button.alpha = 0.8
        return button
    }()
    weak var delegate: EditProfileDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Theme1.blue, NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 30)!]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Theme1.white
        
        navigationItem.title = "Register Your Profile"
        
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(scrollView)
        scrollView.addSubview(mainSV)
        setSVConfig()
        setProfile()
        
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
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        /* mainSV **********/
        mainSV.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        mainSV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18).isActive = true
        mainSV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant:  18).isActive = true
        mainSV.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        mainSV.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true

        mainSV.addArrangedSubview(imageView)
        mainSV.addArrangedSubview(nameSV)
        mainSV.addArrangedSubview(weightSV)
        mainSV.addArrangedSubview(heightSV)
        mainSV.addArrangedSubview(activeSV)
        
        let sv = UIStackView(arrangedSubviews: [UIView(), submitBtn, UIView()])
        sv.axis = .horizontal
        sv.distribution = .equalCentering
        sv.alignment = .center
        mainSV.addArrangedSubview(sv)
        mainSV.axis = .vertical
        mainSV.alignment = .fill
        mainSV.distribution = .fill
        mainSV.spacing = 18
        
        /* imageView ********/
        imageView.addSubview(profileImage)
        imageView.addSubview(pencilBtn)
        profileImage.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 10).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
//        profileImage.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        pencilBtn.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 5).isActive = true
        pencilBtn.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 5).isActive = true
        /* nameSV **********/
        nameSV.addArrangedSubview(nameLabel)
        nameSV.addArrangedSubview(nameTxt)
        nameTxt.heightAnchor.constraint(equalToConstant: heightSeg.bounds.size.height).isActive = true
        nameSV.axis = .horizontal
        nameSV.alignment = .fill
        nameSV.spacing = 10
        
        /* weightSV *********/
        weightSV.addArrangedSubview(weightLabel)
        weightSV.addArrangedSubview(weightTxt)
        weightSV.addArrangedSubview(weightSeg)
        weightSeg.widthAnchor.constraint(equalToConstant: heightSeg.bounds.size.width).isActive = true
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
        activeSV.addArrangedSubview(activePick)
        activeSV.addArrangedSubview(activeText)
        activeText.heightAnchor.constraint(equalToConstant: heightSeg.bounds.size.height).isActive = true
        activeSV.heightAnchor.constraint(equalToConstant: 55).isActive = true
        activeSV.axis = .horizontal
        activeSV.distribution = .fill
        activeSV.alignment = .fill
        activeSV.spacing = 10
        
    }
    
    func setProfile() {
        
        // let savedImagee = UIImage(contentsOfFile: savedImageURL)
        
        // set the image user chose
        if let data = profileImage.image?.pngData() {
            //Create URL of the place picture is saved
            let document = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let url = document.appendingPathComponent("profile.png")
            let urlString = url.absoluteString
            
            do{
                try data.write(to: url)
                defaults.set(urlString, forKey: "Image")
                
            } catch {
                print("error")
            }
        }
        nameTxt.text = defaults.object(forKey: "Name") as? String ?? String()
        weightTxt.text = "\(defaults.double(forKey: "weight"))"
        heightTxt.text = "\(defaults.double(forKey: "height"))"
        activeText.text = defaults.object(forKey: "ActivityType") as? String ?? String()
        
    }
    
    // Access to Camera roll
    @objc func selectPicture(_ sender: UIButton) {
            // if it's available to access photo library
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                // photo library view
                let pickerView = UIImagePickerController()
                // set the place for photo library (camera -> .camera)
                pickerView.sourceType = .photoLibrary
                pickerView.delegate = self
                // show the view
                self.present(pickerView, animated: true)
            }
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        activePick.isHidden = false
        activeText.isHidden = true
    }
    
    @objc func editProfile() {
        
        guard let weight = Double(weightTxt.text!), let height = Double(heightTxt.text!) else {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.05
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: submitBtn.center.x - 12, y: submitBtn.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: submitBtn.center.x + 12, y: submitBtn.center.y))
            submitBtn.layer.add(animation, forKey: "position")
            return
        }
        
        defaults.set(nameTxt.text, forKey: "Name")
        defaults.set(weight, forKey: "weight")
        defaults.set(height, forKey: "height")
        defaults.set(activeText.text, forKey: "ActivityType")
        
        switch weightSeg.selectedSegmentIndex {
        case 0: defaults.set(Weight.kilogram.rawValue, forKey: "weightUnit")
        default: defaults.set(Weight.pound.rawValue, forKey: "weightUnit")
        }
        switch heightSeg.selectedSegmentIndex {
        case 0: defaults.set(Height.centimeter.rawValue, forKey: "heightUnit")
        default: defaults.set(Height.meter.rawValue, forKey: "heightUnit")
        }
        UIView.animate(withDuration: 0.10) {
            self.submitBtn.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        } completion: { (_) in
            UIView.animate(withDuration: 0.10) {
                self.submitBtn.transform = CGAffineTransform.identity
            }
        }
        delegate?.saveProfile()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss(animated: true, completion: nil)
        }
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

extension EditProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
extension EditProfileViewController: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return nil
  }
}

// 1/28 ------------------------------------------------------------------------------
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 写真を選んだ後に呼ばれる処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 選択した写真を取得する
        let image = info[.originalImage] as! UIImage
        // ビューに表示する
        profileImage.image = image
        

        // 写真を選ぶビューを引っ込める
        self.dismiss(animated: true)
    }
}
