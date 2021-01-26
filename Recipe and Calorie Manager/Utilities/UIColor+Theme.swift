//
//  UIColor+Theme.swift
//  Recipe and Calorie Manager
//
//  Created by Macbook Pro on 2021-01-24.
//

import Foundation
import UIKit

extension UIColor {
    struct Theme1 {
        static var green: UIColor { return UIColor(red: 92/255, green: 143/255, blue: 34/255, alpha: 1.0)}
        static var brown: UIColor { return UIColor(red: 117/255, green: 42/255, blue: 7/255, alpha: 1.0)}
        static var yellow: UIColor { return UIColor(red: 251/255, green: 203/255, blue: 123/255, alpha: 1.0)}
        static var orange: UIColor { return UIColor(red: 235/255, green: 94/255, blue: 48/255, alpha: 1.0)}
        static var black: UIColor { return UIColor(red: 47/255, green: 49/255, blue: 49/255, alpha: 1.0)}
        static var white: UIColor { return UIColor(red: 245/255, green: 247/255, blue: 237/255, alpha: 1.0)}
        static var blue: UIColor { return UIColor(red: 49/255, green: 169/255, blue: 184/255, alpha: 1.0)}
    }
}

extension UITextField {
    func useUnderline() {
        let border = CALayer()
        let borderWidth = CGFloat(2.0)
        border.borderColor = UIColor.Theme1.yellow.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
