//
//  MyTabBarController.swift
//  TimeBook
//
//  Created by Hoang Duc on 7/26/19.
//  Copyright © 2019 Hoang Duc. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let notificationCenter = NotificationCenter.default
//        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
//    @objc func appMovedToBackground() {
//        print("App moved to background!")
//    }
    
    let barHeight:CGFloat = 100
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = barHeight
        tabFrame.origin.y = self.view.frame.size.height - barHeight
        self.tabBar.frame = tabFrame
    }
    
    
}

