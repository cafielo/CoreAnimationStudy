//
//  KeyframeAnimationViewController.swift
//  Chap8_Explicit_Animations
//
//  Created by Joonwon Lee on 3/5/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit

class KeyframeAnimationViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // ----- Keyframer Animation
        // create a path
//        let bezierPath = UIBezierPath()
//        bezierPath.move(to: CGPoint(x: 0, y: 150))
//        bezierPath.addCurve(to: CGPoint(x: 300, y: 150) , controlPoint1: CGPoint(x: 75, y: 0), controlPoint2: CGPoint(x: 225, y: 300))
//        
//        // draw the path using a CAShapeLayer
//        let pathLayer = CAShapeLayer()
//        pathLayer.path = bezierPath.cgPath
//        pathLayer.fillColor = UIColor.clear.cgColor
//        pathLayer.strokeColor = UIColor.red.cgColor
//        pathLayer.lineWidth = 3.0
//        containerView.layer.addSublayer(pathLayer)
//        
//        // add the ship
//        let shipLayer = CALayer()
//        shipLayer.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
//        shipLayer.position = CGPoint(x: 0, y: 150)
//        shipLayer.contents = UIImage(named: "Ship.png")?.cgImage
//        containerView.layer.addSublayer(shipLayer)
//        
//        // create the keyframe animation
//        let animation = CAKeyframeAnimation()
//        animation.keyPath = "position"
//        animation.duration = 4.0
//        animation.path = bezierPath.cgPath
//        animation.rotationMode = kCAAnimationRotateAuto
//        shipLayer.add(animation, forKey: nil)
        
        //----- virtual properties
        // add the ship
//        let shipLayer = CALayer()
//        shipLayer.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
//        shipLayer.position = CGPoint(x: 0, y: 150)
//        shipLayer.contents = UIImage(named: "Ship.png")?.cgImage
//        containerView.layer.addSublayer(shipLayer)
//        
//        // animate the ship rotation
//        let animation = CABasicAnimation()
//        animation.keyPath = "transform.rotation"
//        animation.duration = 2.0
////        animation.toValue = NSValue(caTransform3D: CATransform3DMakeRotation(CGFloat.pi, 0, 0, 1))
//        animation.byValue = CGFloat.pi * 2
//        shipLayer.add(animation, forKey: nil)
        
        
        // group Animation
        
        // create a path
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 150))
        bezierPath.addCurve(to: CGPoint(x: 300, y: 150) , controlPoint1: CGPoint(x: 75, y: 0), controlPoint2: CGPoint(x: 225, y: 300))
        
        // draw the path using a CAShapeLayer
        let pathLayer = CAShapeLayer()
        pathLayer.path = bezierPath.cgPath
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.strokeColor = UIColor.red.cgColor
        pathLayer.lineWidth = 3.0
        containerView.layer.addSublayer(pathLayer)
        
        // add a colored layer 
        let colorLayer = CALayer()
        colorLayer.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        colorLayer.position = CGPoint(x: 0, y: 150)
        colorLayer.backgroundColor = UIColor.green.cgColor
        containerView.layer.addSublayer(colorLayer)
        
        // create the keyframe animation
        let animation1 = CAKeyframeAnimation()
        animation1.keyPath = "position"
        animation1.path = bezierPath.cgPath
        animation1.rotationMode = kCAAnimationRotateAuto
        
        // create the color animation
        let animation2 = CABasicAnimation()
        animation2.keyPath = "backgroundColor"
        animation2.toValue = UIColor.red.cgColor
        
        // create group animation
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [animation1, animation2]
        groupAnimation.duration = 4.0
        
        colorLayer.add(groupAnimation, forKey: nil)
    }
}
