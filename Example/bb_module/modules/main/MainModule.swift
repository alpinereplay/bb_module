//
//  MainModule.swift
//  bb_module
//
//  Created by Brian Bal on 8/14/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import bb_module

class MainModule : Module {
    
    var tabBarController : UITabBarController?
    
    override init() {
        super.init()
        self.name = "MainModule"
    }
    
    override func setup() {
        
        route("/") { route in
            let tabVC = UITabBarController()
            self.tabBarController = tabVC
            _ = self.present(to: tabVC, from: nil, mode: .root)
            self.post(Route("/apples/red", from: tabVC))
            self.post(Route("/banana/yellow", from: tabVC))
            return true
        }
        
        route("/app/version") { route in
            self.presentVersionDialog()
            return true
        }
        
    }
    
    func presentVersionDialog() {
        let ac = UIAlertController(title: "Version Info", message: "Version: 0.1.0\nBuild: 1", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        _ = present(to: ac, from: tabBarController, mode: .modal)
    }
    
}
