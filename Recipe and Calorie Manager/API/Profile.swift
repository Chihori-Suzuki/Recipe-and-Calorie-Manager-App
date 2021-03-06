//
//  Profile.swift
//  Recipe and Calorie Manager
//
//  Created by 鈴木ちほり on 2021/01/25.
//

import Foundation

struct Profile {
    var parameter: String
    var value: String
    static var bmr = 0.0
    static var gender: Gender = .male
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
enum Gender: String {
    case male = "male"
    case female = "female"
}
