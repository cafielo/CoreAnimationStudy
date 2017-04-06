//
//  ViewController.swift
//  Chap9_LayerTime
//
//  Created by Joonwon Lee on 3/12/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit

class DurationViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var doorContainerView: UIView!
    @IBOutlet weak var durationField: UITextField!
    @IBOutlet weak var repeatField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    var controls: [UIControl] {
        return [durationField, repeatField, startButton]
    }
    var shipLayer: CALayer!
    var doorLayer: CALayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add the ship 
        shipLayer = CALayer()
        shipLayer.frame = CGRect(x: 0, y: 0, width: 128, height: 128)
        shipLayer.contents = UIImage(named: "Ship")?.cgImage
        
        containerView.layer.addSublayer(shipLayer)
        
        
        // add the door
        doorLayer = CALayer()
        doorLayer.frame = CGRect(x: 0, y: 0, width: 128, height: 200)
//        doorLayer.position = CGPoint(x: 100, y: 0)
        doorLayer.anchorPoint = CGPoint(x: 0, y: 0.5)
        doorLayer.contents = UIImage(named: "Door")?.cgImage
        doorContainerView.layer.addSublayer(doorLayer)
        
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500.0
        doorContainerView.layer.sublayerTransform = perspective
        
        
        
        // apply swing animation
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.y"
        animation.toValue = CGFloat.pi/2
        animation.duration = 2.0
        animation.repeatDuration = CFTimeInterval(Float.infinity)
        animation.autoreverses = true
        doorLayer.add(animation, forKey: nil)
        
        doorLayer.speed = 0
    }
    
    
    @IBAction func scrubDoor(_ sender: UIPanGestureRecognizer) {
        var x = CFTimeInterval(sender.translation(in: view).x)
        
        x /= 200.0
        
        var timeOffset = doorLayer.timeOffset
        timeOffset = min(0.999, max(0.0, timeOffset - x))
        doorLayer.timeOffset = timeOffset
    }
    
    @IBAction func hideKeyBoard(_ sender: UITapGestureRecognizer) {
        
        durationField.resignFirstResponder()
        repeatField.resignFirstResponder()
    }
    
    func setControlsEnabled(enabled: Bool) {
        controls.forEach {
            $0.isEnabled = enabled
            $0.alpha = enabled ? 1.0: 0.25
        }
    }

    @IBAction func start(_ sender: UIButton) {
        let duration = Double(durationField.text ?? "0.0")
        let repeatCount = Float(repeatField.text ?? "0.0")
        
        // Animate the ship rotation 
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation"
        animation.duration = duration!
        animation.repeatCount = repeatCount!
        animation.byValue = CGFloat.pi * 2
        animation.delegate = self
        shipLayer.add(animation, forKey: "rotateAnimation")
        
        setControlsEnabled(enabled: false)
    }
    
    
    

}

extension DurationViewController: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        setControlsEnabled(enabled: true)
    }
}

