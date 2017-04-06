//
//  ViewController.swift
//  Chap11_TimeBaseAnimation
//
//  Created by Joonwon Lee on 3/23/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ballView: UIImageView!
    
    //var duration: CGFloat = 0
    //var timeOffset: CGFloat = 0
    var fromValue = CGPoint.zero
    var toValue = CGPoint.zero
    // var timer: Timer?
    var timer: CADisplayLink?
    var lastStep: CFTimeInterval = 0.0
    var duration: CFTimeInterval = 0
    var timeOffset: CFTimeInterval = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animate()
    }

    func animate() {
        
        // reset baal to top of screen
        ballView.center = CGPoint(x: 150, y: 32)
        
        // configure the animation 
        duration = 1.0
        timeOffset = 0.0
        fromValue = CGPoint(x: 150, y: 32)
        toValue = CGPoint(x: 150, y: 268)
        
        // stop timer if it is already running
        timer?.invalidate()
        
        // start timer
        // timer = Timer.scheduledTimer(timeInterval: 1/60, target: self, selector: #selector(ViewController.step(_:)), userInfo: nil, repeats: true)
        lastStep = CACurrentMediaTime()
        timer = CADisplayLink(target: self, selector: #selector(ViewController.step(_:)))
        timer?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
        timer?.add(to: RunLoop.main, forMode: RunLoopMode.UITrackingRunLoopMode)
    }
    
    func step(_ step: Timer) {
        // calculate time delta
        let thisStep = CACurrentMediaTime()
        let stepDuration = thisStep - lastStep
        lastStep = thisStep
        print(" --\(thisStep),,, dur:\(stepDuration)")
        
        // update time offset
        // timeOffset = min(timeOffset + 1/60, duration)
        timeOffset = min(timeOffset + stepDuration, duration)
        
        // get normalized time offset (in range 0 - 1)
        var time = Float(timeOffset / duration)
        
        // applay easing
        time = bounceEaseOut(t: time)
        
        // interpolate position
        let position = interpolateFromValue(fromValue: fromValue, toValue: toValue, time: CGFloat(time))
        
        guard position is CGPoint else {
            return
        }
        ballView.center = position as! CGPoint
        
        // stop the timer if we've reached the end of the animation
        if timeOffset >= duration {
            timer?.invalidate()
            timer = nil
        }
        
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
    
    func interpolateFromValue(fromValue: Any, toValue: Any, time: CGFloat) -> Any {
        if let from = fromValue as? CGPoint, let toVal = toValue as? CGPoint {
            let x = interpolate(from: from.x, to: toVal.x, time: time)
            let y = interpolate(from: from.y, to: toVal.y, time: time)
            let result = CGPoint(x: x, y: y)
            return result
        }
        return time < 0.5 ? fromValue: toValue
    }
    
    func interpolate(from: CGFloat, to: CGFloat, time: CGFloat) -> CGFloat {
        return (to - from) * time + from
    }

}

