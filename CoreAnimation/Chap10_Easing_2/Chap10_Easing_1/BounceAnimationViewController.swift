//
//  BounceAnimationViewController.swift
//  Chap10_Easing_1
//
//  Created by Joonwon Lee on 3/19/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit

class BounceAnimationViewController: UIViewController {

    @IBOutlet weak var ballView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animate()
    }
    
    func interpolate(from: CGFloat, to: CGFloat, time: CGFloat) -> CGFloat {
        return (to - from) * time + from
    }
    
    func interpolateFromValue(fromValue: Any, toValue: Any, time: CGFloat) -> Any {
        if let from = fromValue as? CGPoint, let toVal = toValue as? CGPoint {
           let x = interpolate(from: from.x, to: toVal.x, time: time)
           let y = interpolate(from: from.y, to: toVal.y, time: time)
            let result = CGPoint(x: x, y: y)
            return result
        }
        return time < 0.5 ? fromValue: toValue
    }
    

    func animate() {
        ballView.center = CGPoint(x: 150, y: 32)
        
        // create keyframe animation 
//        let animation = CAKeyframeAnimation()
//        animation.keyPath = "position"
//        animation.duration = 1.0
//        animation.delegate = self
//        animation.values = [
//                NSValue(cgPoint: CGPoint(x:150, y:32)),
//                NSValue(cgPoint: CGPoint(x:150, y:268)),
//                NSValue(cgPoint: CGPoint(x:150, y:140)),
//                NSValue(cgPoint: CGPoint(x:150, y:268)),
//                NSValue(cgPoint: CGPoint(x:150, y:220)),
//                NSValue(cgPoint: CGPoint(x:150, y:268)),
//                NSValue(cgPoint: CGPoint(x:150, y:250)),
//                NSValue(cgPoint: CGPoint(x:150, y:268))
//        ]
//        
//        animation.timingFunctions = [
//            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn),
//            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
//            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn),
//            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
//            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn),
//            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
//            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
//        ]
//        
//        animation.keyTimes = [0.0, 0.3, 0.5, 0.7, 0.8, 0.9, 0.95, 1]
//        ballView.layer.position = CGPoint(x: 150, y: 268)
//        ballView.layer.add(animation, forKey: nil)
        
        // automation
        let from = CGPoint(x: 150, y: 32)
        let to = CGPoint(x: 150, y: 268)
        let duration: CFTimeInterval = 1.0
        
        // generate keyframes
        let numFrames = Int(duration * 60)
        var frames = [Any]()
        
        for i in 0..<numFrames {
            var time = 1 / CGFloat(numFrames) * CGFloat(i)
            // apply easing 
            time = CGFloat(bounceEaseOut(t: Float(time)))
            
            frames.append(interpolateFromValue(fromValue: from, toValue: to, time: time))
        }
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.duration = 1.0
        animation.delegate = self
        animation.values = frames
        
        // apply animation
        ballView.layer.add(animation, forKey: nil)
    }
    
    func bounceEaseOut(t: Float) -> Float {
        if (t < 4/11.0) {
            return (121 * t * t)/16.0
        } else if (t < 8/11.0) {
            return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0
        } else if (t < 9/10.0) {
            return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0
        }
        return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0
    }
}

extension BounceAnimationViewController: CAAnimationDelegate {
    
}
