//
//  TabBarController.swift
//  Chap8_Explicit_Animations
//
//  Created by Joonwon Lee on 3/9/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // set up crossfade transition
        let transition = CATransition()
        transition.type = kCATransitionFade
        
        // apply transition to tabbar controller's view
        view.layer.add(transition, forKey: nil)
    }
}
