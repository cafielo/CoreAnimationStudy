//
//  ClockViewController.swift
//  Chap10_Easing_1
//
//  Created by Joonwon Lee on 3/19/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController, CAAnimationDelegate {
    
    @IBOutlet weak var hourHandImageView: UIImageView!
    @IBOutlet weak var minuteHandImageView: UIImageView!
    @IBOutlet weak var secondHandImageView: UIImageView!
    var timer: Timer?
    
    @IBOutlet weak var layerView: UIView!
    var colorLayer: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CABasicAnimation
        colorLayer = CALayer()
        colorLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        colorLayer.backgroundColor = UIColor.blue.cgColor
        layerView.layer.addSublayer(colorLayer)
        
        // CAAnimationDelegate
        hourHandImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        minuteHandImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        secondHandImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        
        updateHands(animated: false)
        
    }
    
    @IBAction func changeColor(_ sender: Any) {
        //        let red = CGFloat(arc4random()) / CGFloat(UINT32_MAX)
        //        let green = CGFloat(arc4random()) / CGFloat(UINT32_MAX)
        //        let blue = CGFloat(arc4random()) / CGFloat(UINT32_MAX)
        //        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        //
        //        // create a basic animation
        //        let animation = CABasicAnimation()
        //        animation.keyPath = "backgroundColor"
        //        animation.toValue = color.cgColor
        //        animation.delegate = self
        //
        //        // apply animation without snapback
        //        applyBasicAnimation(animation: animation, layer: colorLayer)
        //
        // KeyframeAnimation
        let animation = CAKeyframeAnimation()
        animation.keyPath = "backgroundColor"
        animation.duration = 2.0
        animation.values = [UIColor.blue.cgColor, UIColor.red.cgColor, UIColor.green.cgColor, UIColor.blue.cgColor]
        
        self.colorLayer.add(animation, forKey: nil)
        
    }
    
    func applyBasicAnimation(animation: CABasicAnimation, layer: CALayer) {
        // set the from value (
        animation.fromValue = layer.value(forKey: animation.keyPath!)
        
        // update the propery in advance
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        layer.setValue(animation.toValue, forKey: animation.keyPath!)
        CATransaction.commit()
        
        // apply animation to layer
        layer.add(animation, forKey: nil)
        
    }
    
}
extension ClockViewController {
    
    func tick() {
        updateHands(animated: true)
    }
    
    func updateHands(animated: Bool) {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let units: Set<Calendar.Component> = Set([.hour, .minute, .second])
        let components = calendar.dateComponents(units, from: Date())
        
        let hAngle = CGFloat((Double(components.hour!) / 12.0) * M_PI * 2.0)
        let mAngle = CGFloat((Double(components.minute!) / 60.0) * M_PI * 2.0)
        let sAngle = CGFloat((Double(components.second!) / 60.0) * M_PI * 2.0)
        
        set(angle: hAngle, forHand: hourHandImageView, animated: animated)
        set(angle: mAngle, forHand: minuteHandImageView, animated: animated)
        set(angle: sAngle, forHand: secondHandImageView, animated: animated)
    }
    
    func set(angle: CGFloat, forHand handView: UIView, animated: Bool) {
        let transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        if animated {
            let animation = CABasicAnimation()
            animation.keyPath = "transform"
            animation.fromValue = handView.layer.presentation()?.value(forKey: "transform")
            animation.toValue = NSValue(caTransform3D: transform)
            animation.duration = 0.5
            animation.delegate = self
            animation.timingFunction = CAMediaTimingFunction(controlPoints: 1, 0, 0.75, 1)
            
            
//            animation.setValue(handView, forKey: "handView")
            handView.layer.transform = transform
            handView.layer.add(animation, forKey: nil)
        } else {
            handView.layer.transform = transform
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let animation = anim as? CABasicAnimation {
            let handView = anim.value(forKey: "handView") as? UIView
            handView?.layer.transform = animation.toValue as! CATransform3D
        }
    }
}

