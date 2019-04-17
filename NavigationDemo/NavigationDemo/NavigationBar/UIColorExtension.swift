//
//  UIColorExtension.swift
//  NavigationDemo
//
//  Created by midland on 2019/4/17.
//  Copyright © 2019年 midland. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(rgbValue: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
