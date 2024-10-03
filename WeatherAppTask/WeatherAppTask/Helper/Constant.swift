//
//  Constant.swift
//  WeatherAppTask
//
//  Created by Eslam Sebaie on 01/10/2024.
//

import Foundation
import UIKit
enum Constants {
    static let apiKey = "dbb04b026e8e7ce0eb6105f8b1cf803b"
}
extension Date {
    func formatAsString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, HH:mm"
        return dateFormatter.string(from: self)
    }
}
extension UIView {
    func dropShadowWithRounded()  {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width:5 , height: 5)
        self.layer.shadowRadius = 5.0
    }
}
