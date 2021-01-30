//
//  MainTabBarController.swift
//  Recipe and Calorie Manager
//
//  Created by Kazunobu Someya on 2021-01-19.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    // UserDefaults
    let defaults = UserDefaults.standard
    let recipeListIcon = UIImage(named: "recipeList_tabbar_icon")
    let addRecipeIcon = UIImage(named: "addRecipe_tabbar_icon")
    let profileIcon = UIImage(named: "profile_tabbar_icon")
    private var bounceAnimation: CAKeyframeAnimation = {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.4, 0.9, 1.02, 1.0]
        bounceAnimation.duration = 0.4
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        return bounceAnimation
    }()
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return viewController != tabBarController.selectedViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        let recipeListVC = RecipeListViewController()
        recipeListVC.tabBarItem = UITabBarItem(title: "Recipe List", image: recipeListIcon, tag: 0)
        // make a viewController for addRecipe screen
        let addRecipeVC = AddRecipeViewController()
        addRecipeVC.tabBarItem = UITabBarItem(title: "Add Recipe", image: addRecipeIcon, tag: 1)
        // make a viewController for profile screen
        var profileVC: UIViewController
        if defaults.object(forKey: "Name") != nil {
            profileVC = showProfileViewController()
        } else {
            profileVC = ProfileViewController()
        }
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: profileIcon ,tag: 2)
        // make a viewController for recipe list screen
        let viewControllers = [recipeListVC, addRecipeVC, profileVC]
        self.viewControllers = viewControllers.map { UINavigationController(rootViewController: $0) }
        self.selectedIndex = 1
        
        tabBar.tintColor = UIColor.Theme1.black
        let appearance = tabBar.standardAppearance
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        appearance.backgroundColor = UIColor.Theme1.white
        tabBar.standardAppearance = appearance;
    }
}

extension MainTabBarController {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        Recipe.newRecipeCount = 0
        item.badgeValue = nil
        
        guard let idx = tabBar.items?.firstIndex(of: item), tabBar.subviews.count > idx + 1, let imageView = tabBar.subviews[idx + 1].subviews.compactMap({ $0 as? UIImageView }).first else {
            return
        }
        imageView.layer.add(bounceAnimation, forKey: nil)
        tabBar.tintColor = .red
    }
}
