//
//  ViewController.swift
//  Chap7_Transactions
//
//  Created by Joonwon Lee on 2/26/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var layerView: UIView!
    var colorLayer: CALayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorLayer = CALayer()
        colorLayer!.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        colorLayer!.backgroundColor = UIColor.red.cgColor
        
        // add a custom action 
//        let transition = CATransition()
//        transition.type = kCATransitionPush
//        transition.subtype = kCATransitionFromLeft
//        colorLayer!.actions = ["backgroundColor": transition]
//        layerView.layer.addSublayer(colorLayer!)
        view.layer.addSublayer(colorLayer!)
        
//        layerView.layer.backgroundColor = UIColor.blue.cgColor
//        print("---outside:\(layerView.action(for: layerView.layer, forKey: "backgroundColor"))")
//        UIView.beginAnimations(nil, context: nil)
//        print("---inside:\(layerView.action(for: layerView.layer, forKey: "backgroundColor"))")
//        UIView.commitAnimations()
    }
    
    
    @IBAction func changeColor(_ sender: UIButton) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
//        CATransaction.setCompletionBlock {
//            let transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
//            self.colorLayer?.setAffineTransform(transform)
//        }
        let red = CGFloat(arc4random()) / CGFloat(UINT32_MAX)
        let green = CGFloat(arc4random()) / CGFloat(UINT32_MAX)
        let blue = CGFloat(arc4random()) / CGFloat(UINT32_MAX)
        self.colorLayer?.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1).cgColor
//        layerView.layer.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1).cgColor
        CATransaction.commit()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
        let point = (touches.first as AnyObject).location(in: self.view)
        if colorLayer?.presentation()?.hitTest(point) != nil {
            let red = CGFloat(arc4random()) / CGFloat(UINT32_MAX)
            let green = CGFloat(arc4random()) / CGFloat(UINT32_MAX)
            let blue = CGFloat(arc4random()) / CGFloat(UINT32_MAX)
            colorLayer?.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1).cgColor
        } else {
            CATransaction.begin()
            CATransaction.setAnimationDuration(4)
            colorLayer?.position = point
            CATransaction.commit()
        }
    }
}



