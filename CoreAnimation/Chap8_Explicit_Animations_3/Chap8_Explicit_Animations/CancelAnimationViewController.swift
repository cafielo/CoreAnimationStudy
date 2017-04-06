//
//  CancelAnimationViewController.swift
//  Chap8_Explicit_Animations
//
//  Created by Joonwon Lee on 3/9/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit

class CancelAnimationViewController: UIViewController, CAAnimationDelegate {

    @IBOutlet weak var containerView: UIView!
    var shipLayer: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add the ship
        shipLayer = CALayer()
        shipLayer.frame = CGRect(x: 36, y: 36, width: 128, height: 128)
//        shipLayer.position = CGPoint(x: 150, y: 150)
        shipLayer.contents = UIImage(named: "Ship")?.cgImage
        
        containerView.layer.addSublayer(shipLayer)
    }
    
    @IBAction func start(_ sender: UIButton) {
       let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation"
        animation.duration = 2.0
        animation.byValue = CGFloat.pi * 2
        animation.delegate = self
        shipLayer.add(animation, forKey: "rotateAnimation")
    }
    
    @IBAction func stop(_ sender: UIButton) {
        shipLayer.removeAnimation(forKey: "rotateAnimation")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        // log
        let finished = flag ? "true" : "false"
        print("The animation stopped finished:\(finished)")
    }
}
