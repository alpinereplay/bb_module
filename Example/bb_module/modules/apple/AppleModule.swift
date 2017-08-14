//
//  AppleModule.swift
//  bb_module
//
//  Created by Brian Bal on 8/14/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import bb_module

class AppleModule: Module {
    
    var redAppleVc : UIViewController?
    
    override init() {
        super.init()
        name = "AppleModule"
    }
    
    override func setup() {
        
        route("/apples/red") { route in
            let vc = UIViewController()
            vc.view.backgroundColor = .red
            vc.navigationItem.title = "Apples"
            vc.tabBarItem = UITabBarItem(title: "Apples", image: nil, selectedImage: nil)
            
            let button = UIButton()
            button.setTitle("Green", for: .normal)
            button.addTarget(self, action: #selector(AppleModule.postGreenAppleRoute), for: .touchUpInside)
            button.frame = CGRect(x: 10, y: 200, width: 250, height: 50)
            button.backgroundColor = .green
            vc.view.addSubview(button)
            
            self.redAppleVc = vc
            
            _ = self.present(to: vc, from: route.from, mode: .tab)
            return true
        }
        
        route("/apples/green") { route in
            let vc = UIViewController()
            vc.navigationItem.title = "Green Apples"
            vc.view.backgroundColor = .green
            _ = self.present(to: vc, from: route.from, mode: .push)
            return true
        }
        
    }
    
    @objc func postGreenAppleRoute() {
        router?.post("/apples/green", from: redAppleVc)
    }
    
    
}
