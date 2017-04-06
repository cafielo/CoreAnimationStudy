//
//  ViewController.swift
//  Chap10_Easing_1
//
//  Created by Joonwon Lee on 3/16/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var layerView: UIView!
    var colorLayer: CALayer?
    var colorView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        colorLayer = CALayer()
//        colorLayer?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        colorLayer?.position = CGPoint(x: view.bounds.width/2 , y: view.bounds.height/2)
//        colorLayer?.backgroundColor = UIColor.red.cgColor
//        view.layer.addSublayer(colorLayer!)
        
//        colorView = UIView()
//        colorView?.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
//        colorView?.center = CGPoint(x: view.bounds.width/2 , y: view.bounds.height/2)
//        colorView?.backgroundColor = UIColor.red
//        view.addSubview(colorView!)
        
        
        colorLayer = CALayer()
        colorLayer?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        colorLayer?.position = CGPoint(x: view.bounds.width/2 , y: view.bounds.height/2)
        colorLayer?.backgroundColor = UIColor.red.cgColor
        layerView.layer.addSublayer(colorLayer!)
    }
    
    @IBAction func changeColor(_ sender: UIButton) {
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "backgroundColor"
        animation.duration = 2.0
        animation.values = [UIColor.red.cgColor, UIColor.blue.cgColor, UIColor.green.cgColor, UIColor.red.cgColor]
        
        let fn = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
//        let fn = CAMediaTimingFunction(
        
        animation.timingFunctions = [fn, fn, fn]
        
        colorLayer?.add(animation, forKey: nil)
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        CATransaction.begin()
//        CATransaction.setAnimationDuration(1.0)
//        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut))
//        colorLayer?.position = touches.first!.location(in: view)
//        CATransaction.commit()
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { 
            self.colorView?.center = touches.first!.location(in: self.view)
        }, completion: nil)
    }
}

