//
//  BananaModule.swift
//  bb_module
//
//  Created by Brian Bal on 8/14/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import bb_module

class BananaModule : Module {
    
    var bananaViewController : UIViewController?
    
    override init() {
        super.init()
        self.name = "BananaModule"
    }
    
    override func setup() {
        
        regexRoute("/banana/*") { route in
            let vc = UIViewController()
            vc.view.backgroundColor = .yellow
            vc.navigationItem.title = "Banana"
            vc.tabBarItem = UITabBarItem(title: "Banana", image: nil, selectedImage: nil)
            
            let button = UIButton()
            button.setTitle("Version Info", for: .normal)
            button.addTarget(self, action: #selector(BananaModule.postVersionRoute), for: .touchUpInside)
            button.frame = CGRect(x: 10, y: 200, width: 250, height: 50)
            button.backgroundColor = .purple
            vc.view.addSubview(button)
            
            self.bananaViewController = vc
            _ = self.present(to: vc, from: route.from, mode: .tab)
            return true
        }
        
    }
    
    @objc func postVersionRoute() {
        router?.post("/app/version", from: bananaViewController)
    }
    
}
