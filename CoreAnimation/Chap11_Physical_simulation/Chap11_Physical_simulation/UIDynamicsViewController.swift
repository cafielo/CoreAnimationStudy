//
//  UIDynamicsViewController.swift
//  Chap11_Physical_simulation
//
//  Created by Joonwon Lee on 3/27/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit

class UIDynamicsViewController: UIViewController {
    
    var box : UIView?
    
    func addBox(location: CGRect) {
//        let newBox = UIView(frame: location)
//        newBox.backgroundColor = UIColor.red
        box = UIView(frame: location)
        box?.backgroundColor = UIColor.red
        view.addSubview(box!)
    }
    
    var animator: UIDynamicAnimator? = nil
    let gravity = UIGravityBehavior()
    
    func createAnimatorStuff() {
        animator = UIDynamicAnimator(referenceView: view)
        gravity.addItem(box!)
        gravity.gravityDirection = CGVector(dx: 0.0, dy: 1.0)
        animator?.addBehavior(gravity)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let ball = UIView(frame: CGRect(x: 100, y: 150, width: 200, height: 200))
        ball.backgroundColor = UIColor.green
        view.addSubview(ball)
        
        addBox(location: CGRect(x: 100, y: 150, width: 200, height: 200))
        createAnimatorStuff()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
