//
//  Test1ViewController.swift
//  NavigationDemo
//
//  Created by midland on 2019/4/17.
//  Copyright © 2019年 midland. All rights reserved.
//

import UIKit

class Test1ViewController: UIViewController {
    
    override var prefersNavigationBarStyle: UINavigationBarStyle {
        return .custom
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        nv.navigationBar.barTintColor = .orange
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // nv.navigationBar.barTintColor = UIColor.orange.withAlphaComponent(0.5)
    }
    

}
