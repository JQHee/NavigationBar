//
//  UIImageExtension.swift
//  NavigationDemo
//
//  Created by midland on 2019/4/17.
//  Copyright © 2019年 midland. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    static func create(_ color: UIColor, _ size: CGSize = CGSize(width: 1, height: 0.5)) -> UIImage? {
        if size.width <= 0 || size.height <= 0 { return nil }
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setFillColor(color.cgColor)
        ctx?.fill(rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
