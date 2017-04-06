//
//  RelativeTimeViewController.swift
//  Chap9_LayerTime
//
//  Created by Joonwon Lee on 3/13/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit

class RelativeTimeViewController: UIViewController {
    
    @IBOutlet weak var timeOffsetLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var timeOffsetSlider: UISlider!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var containerView: UIView!
    var bezierPath: UIBezierPath!
    var shipLayer: CALayer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // create a path
        bezierPath = UIBezierPath()
        bezierPath?.move(to: CGPoint(x: 0, y: 150))
        bezierPath?.addCurve(to: CGPoint(x:300, y:150), controlPoint1: CGPoint(x:75, y:0), controlPoint2: CGPoint(x:225, y:300))
        
        // draw the path using a CAShapeLayer
        let pathLayer = CAShapeLayer()
        pathLayer.path = bezierPath?.cgPath
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.strokeColor = UIColor.red.cgColor
        pathLayer.lineWidth = 3.0
        containerView.layer.addSublayer(pathLayer)
        
        // add the ship
        shipLayer = CALayer()
        shipLayer.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        shipLayer.position = CGPoint(x: 0, y: 150)
        shipLayer.contents = UIImage(named: "Ship")?.cgImage
        containerView.layer.addSublayer(shipLayer)
        
        
    }
    
    
    @IBAction func play(_ sender: UIButton) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.timeOffset = CFTimeInterval(timeOffsetSlider.value)
        animation.speed = speedSlider.value
        animation.duration = 1
        animation.path = bezierPath!.cgPath
        animation.rotationMode = kCAAnimationRotateAuto
        animation.isRemovedOnCompletion = false
        shipLayer.add(animation, forKey: "slide")
        
    
    }
    
    @IBAction func updateSlider(_ sender: UISlider) {
        let timeOffset = CFTimeInterval(timeOffsetSlider.value)
        timeOffsetLabel.text = String(format: "%0.2f", timeOffset)
        
        let speed = speedSlider.value
        speedLabel.text = String(format: "%0.2f", speed)
    }
    
}
