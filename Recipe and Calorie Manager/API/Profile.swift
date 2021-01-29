//
//  Profile.swift
//  Recipe and Calorie Manager
//
//  Created by 鈴木ちほり on 2021/01/25.
//

import Foundation

struct Profile {
    var palameter: String
    var value: String
    static var bmr = 0.0
}

enum ActivityType: String, CaseIterable {
    case sedentary = "Sedentary"
    case lightlyActive = "Lightly Active"
    case moderatelyActive = "Moderately Active"
    case veryActive = "Very Active"
    case extraActive = "Extra Active"
}
enum Weight: Double {
    case pound
    case kilogram
}
enum Height: Double {
    case centimeter
    case meter
}
