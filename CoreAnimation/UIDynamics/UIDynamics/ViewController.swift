//
//  ViewController.swift
//  UIDynamics
//
//  Created by Joonwon Lee on 3/27/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var blueBoxView: UIView?
    var redBoxView: UIView?
    var animator: UIDynamicAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var frameRect = CGRect(x: 10, y: 20, width: 80, height: 80)
        blueBoxView = UIView(frame: frameRect)
        blueBoxView?.backgroundColor = UIColor.blue
        
        frameRect = CGRect(x: 150, y: 20, width: 60, height: 60)
        redBoxView = UIView(frame: frameRect)
        redBoxView?.backgroundColor = UIColor.red
        
        view.addSubview(blueBoxView!)
        view.addSubview(redBoxView!)
        
        
        // --- UIDynamics ---
      
        
        
        // 1. Dynamic Behavior 를 적용할 뷰를 이용하여 DynamicAnimator 생성
        animator = UIDynamicAnimator(referenceView: view)
        
        
        
        
        
        // 2. Dynamic Behavior 추가: 중력
        let gravity = UIGravityBehavior(items: [blueBoxView!, redBoxView!])
        let vector = CGVector(dx: 0.0, dy: 1.0)
        gravity.gravityDirection = vector
        animator?.addBehavior(gravity)
        
        // 3. Dynamic Behavior 추가: 충돌 추가
        let collision = UICollisionBehavior(items: [blueBoxView!, redBoxView!])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collision)
        
        // 4. Dynamic Behavior 추가:탄성 추가
        let elasticBehavior = UIDynamicItemBehavior(items: [blueBoxView!])
        elasticBehavior.elasticity = 0.5
        animator?.addBehavior(elasticBehavior)
    }
}
