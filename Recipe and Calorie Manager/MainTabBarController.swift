//
//  MainTabBarController.swift
//  Recipe and Calorie Manager
//
//  Created by Kazunobu Someya on 2021-01-19.
//

import UIKit

class MainTabBarController: UITabBarController {
    // UserDefaults
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let recipeListVC = RecipeListViewController()
        recipeListVC.tabBarItem = UITabBarItem(title: "Recipe List", image: UIImage(named: "recipeList_tabbar_icon"), tag: 0)
        // make a viewController for addRecipe screen
        let addRecipeVC = AddRecipeViewController()
        addRecipeVC.tabBarItem = UITabBarItem(title: "Add Recipe", image: UIImage(named: "addRecipe_tabbar_icon"), tag: 1)
        // make a viewController for profile screen
        var profileVC: UIViewController
        if defaults.object(forKey: "Name") != nil {
            profileVC = showProfileViewController()
        } else {
            profileVC = ProfileViewController()
        }
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile_tabbar_icon"), tag: 2)
        // make a viewController for recipe list screen
        let viewControllers = [recipeListVC, addRecipeVC, profileVC]
        self.viewControllers = viewControllers.map { UINavigationController(rootViewController: $0) }
        self.selectedIndex = 1
        
//        if #available(iOS 13, *) {
            // iOS 13:
        let appearance = tabBar.standardAppearance
        appearance.configureWithOpaqueBackground()
        appearance.shadowImage = nil
        appearance.shadowColor = UIColor.Theme1.white
        tabBar.standardAppearance = appearance
//        }
//        else {
            // iOS 12 and below:
//            tabBar.shadowImage = UIImage()
//            tabBar.backgroundImage = UIImage()
//            appearance.shadowColor = UIColor.Theme1.white
//        }
    }
}
