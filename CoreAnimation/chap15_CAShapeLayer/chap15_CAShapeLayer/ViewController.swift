//
//  ViewController.swift
//  chap15_CAShapeLayer
//
//  Created by Joon on 16/04/2017.
//  Copyright © 2017 Joon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 15.1 create shape layer
        //        let blueLayer = CAShapeLayer()
        //        blueLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        //        blueLayer.fillColor = UIColor.blue.cgColor
        //        blueLayer.path = UIBezierPath(roundedRect: CGRect(x:0, y:0, width: 100, height:100) , cornerRadius: 20).cgPath
        //        
        //        view.layer.addSublayer(blueLayer)
        
        // 15.2 create layer 
        let blueLayer = CALayer()
        blueLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        blueLayer.contentsCenter = CGRect(x: 0.5, y: 0.5, width: 0, height: 0)
        blueLayer.contentsScale = UIScreen.main.scale
        blueLayer.contents = #imageLiteral(resourceName: "Rounded").cgImage
        
        view.layer.addSublayer(blueLayer)
        
        
        
    }



}

