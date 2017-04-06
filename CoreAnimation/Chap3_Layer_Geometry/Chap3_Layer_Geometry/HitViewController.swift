//
//  HitViewController.swift
//  Chap3_Layer_Geometry
//
//  Created by Joonwon Lee on 2/8/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit
import QuartzCore

class HitViewController: UIViewController {
    
    @IBOutlet weak var layerView: UIView!
    var blueLayer: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blueLayer = CALayer()
        blueLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        blueLayer.backgroundColor = UIColor.blue.cgColor
        
        layerView.layer.addSublayer(blueLayer)
    }
    
    
    // containsPoint
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        //get touch position relative to main view
//        var point = (touches.first as AnyObject).location(in: self.view)
//        
//        //convert point to the white layer's coordinates
//        point = layerView.layer.convert(point, from: view.layer)
//        
//        //get layer using containsPoint:
//        if layerView.layer.contains(point) {
//            //convert point to blueLayer’s coordinates
//            point = blueLayer.convert(point, from: layerView.layer)
//            
//            if blueLayer.contains(point) {
//                let alert = UIAlertController(title: "Inside Blue Layer", message: nil, preferredStyle: .alert)
//                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//                alert.addAction(alertAction)
//                present(alert, animated: true, completion: nil)
//            } else {
//                let alert = UIAlertController(title: "Inside White Layer", message: nil, preferredStyle: .alert)
//                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//                alert.addAction(alertAction)
//                present(alert, animated: true, completion: nil)
//            }
//        }
//    }
    
    // hitTest
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = (touches.first as AnyObject).location(in: self.view)
        let layer = layerView.layer.hitTest(point)
        
        if layer == blueLayer {
            let alert = UIAlertController(title: "Inside Blue Layer", message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        } else if layer == layerView.layer {
            let alert = UIAlertController(title: "Inside White Layer", message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        }
    }
}
