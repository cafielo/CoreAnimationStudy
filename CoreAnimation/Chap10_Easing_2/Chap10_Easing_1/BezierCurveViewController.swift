//
//  BezierCurveViewController.swift
//  Chap10_Easing_1
//
//  Created by Joonwon Lee on 3/19/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit

class BezierCurveViewController: UIViewController {

    @IBOutlet weak var layerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // create timing function
        let function = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        // get control points
        var cPoint1 = UnsafeMutablePointer<Float>.allocate(capacity: 2)
        var cPoint2 = UnsafeMutablePointer<Float>.allocate(capacity: 2)
        function.getControlPoint(at: 1, values: cPoint1)
        function.getControlPoint(at: 2, values: cPoint2)
        let point1 = CGPoint(x: Double(cPoint1[0]), y: Double(cPoint1[1]))
        let point2 = CGPoint(x: Double(cPoint2[0]), y: Double(cPoint2[1]))
        
        print(point1, point2)
        // create curve
        var path = UIBezierPath()
        path.move(to: CGPoint.zero)
        path.addCurve(to: CGPoint(x: 1, y: 1) , controlPoint1: point1, controlPoint2: point2)
        
        // scale the path up to a reasonable size for display
        path.apply(CGAffineTransform(scaleX: 200, y: 200))
        
        // create shape layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 4.0
        shapeLayer.path = path.cgPath
        layerView.layer.addSublayer(shapeLayer)
        
        // flip geometry so that 0,0 is in the bottom-left
        layerView.layer.isGeometryFlipped = true

    }
}
