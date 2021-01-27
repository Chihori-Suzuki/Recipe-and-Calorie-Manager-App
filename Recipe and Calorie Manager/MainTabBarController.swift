//
//  MainTabBarController.swift
//  Recipe and Calorie Manager
//
//  Created by Kazunobu Someya on 2021-01-19.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let recipeListVC = RecipeListViewController()
        recipeListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        // make a viewController for addRecipe screen
        let addRecipeVC = AddRecipeViewController()
        addRecipeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        // make a viewController for profile screen
        
//        let profileVC = ProfileViewController()
//        let profileVC = EditProfileViewController()
        let profileVC = showProfileViewController()
        profileVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        // make a viewController for recipe list screen
        let viewControllers = [recipeListVC, addRecipeVC, profileVC]
        self.viewControllers = viewControllers.map { UINavigationController(rootViewController: $0) }
        self.selectedIndex = 1
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
