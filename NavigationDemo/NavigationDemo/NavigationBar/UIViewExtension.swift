//
//  UIViewExtension.swift
//  NavigationDemo
//
//  Created by midland on 2019/4/17.
//  Copyright © 2019年 midland. All rights reserved.
//

import Foundation
import UIKit


/// A wrapper that around `fd_` properties.
extension NVNameSpace where Base: UIView {
    
    var left: CGFloat {
        get { return base.frame.origin.x }
        set { base.frame.origin.x = newValue }
    }
    
    var top: CGFloat {
        get { return base.frame.origin.y }
        set { base.frame.origin.y = newValue }
    }
    
    var right: CGFloat {
        get { return base.frame.origin.x + base.frame.size.width }
        set { base.frame.origin.x = newValue - base.frame.size.width }
    }
    
    var bottom: CGFloat {
        get { return base.frame.origin.y + base.frame.size.height }
        set { base.frame.origin.y = newValue - base.frame.size.height }
    }
    
    var width: CGFloat {
        get { return base.frame.size.width }
        set { base.frame.size.width = newValue }
    }
    
    var height: CGFloat {
        get { return base.frame.size.height }
        set { base.frame.size.height = newValue }
    }
    
    var centerX: CGFloat {
        get { return base.center.x }
        set { base.center = CGPoint(x: newValue, y: base.center.y) }
    }
    
    var centerY: CGFloat {
        get { return base.center.y }
        set { base.center = CGPoint(x: base.center.x, y: newValue) }
    }
    
    var origin: CGPoint {
        get { return base.frame.origin }
        set { base.frame.origin = newValue }
    }
    
    var size: CGSize {
        get { return base.frame.size }
        set { base.frame.size = newValue }
    }
}

extension UIView {

}
