//
//  ViewController.swift
//  NavigationDemo
//
//  Created by midland on 2019/4/17.
//  Copyright © 2019年 midland. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override var prefersNavigationBarStyle: UINavigationBarStyle {
        return .system
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let VC = Test1ViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }


}

