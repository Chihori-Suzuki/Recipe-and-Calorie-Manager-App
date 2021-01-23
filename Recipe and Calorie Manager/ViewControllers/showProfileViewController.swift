//
//  showProfileViewController.swift
//  Recipe and Calorie Manager
//
//  Created by Chiori Suzuki on 2021/01/21.
//

import UIKit
import CoreData

class showProfileViewController: UIViewController {

    var people: [NSManagedObject] = []
    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}


