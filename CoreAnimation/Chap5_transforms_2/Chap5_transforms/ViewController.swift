//
//  ViewController.swift
//  Chap5_transforms
//
//  Created by Joonwon Lee on 2/16/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var innerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //--------creating transform--------
        //        let transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)

//        var transform = CGAffineTransform.identity
    
        
        //--------combining transform--------
//        // scale 50%
//        transform = transform.scaledBy(x: 0.5, y: 0.5)
//        // rotate 30 degree
//        transform = transform.rotated(by: CGFloat.pi/180 * 30)
//        // translate by 200 point
//        transform = transform.translatedBy(x: 200, y: 0)
        
        //--------shear transform--------
//        imageView.layer.setAffineTransform(CGAffineTransformMakeShear(x: 1,y: 0))
        
        //--------3D transform-------- 45 degree
//        let transform3D = CATransform3DMakeRotation(CGFloat.pi/4, 0, 1, 0)
//        imageView.layer.transform = transform3D
        
        //--------Apply perspective-------- 45 degree
//        var transform3D = CATransform3DIdentity
//        
//        transform3D.m34 = -1 / 500
//        
//        transform3D = CATransform3DRotate(transform3D, CGFloat.pi/4, 0, 1, 0)
//        imageView.layer.transform = transform3D
        
        
         //--------Vanishing Point
//        var transform3D = CATransform3DIdentity
//        transform3D.m34 = -1 / 500
//        view.layer.sublayerTransform = transform3D
//        
//        
//        let transform1 = CATransform3DRotate(transform3D, CGFloat.pi/4, 0, 1, 0)
//        leftImageView.layer.transform = transform1
//        
//        let transform2 = CATransform3DRotate(transform3D, -CGFloat.pi/4, 0, 1, 0)
//        rightImageView.layer.transform = transform2
        
        // Layer flattening
        // z-axis
//        let outer = CATransform3DMakeRotation(CGFloat.pi/4, 0, 0, 1)
//        outerView.layer.transform = outer
//        
//        let inner = CATransform3DMakeRotation( -CGFloat.pi/4, 0, 0, 1)
//        innerView.layer.transform = inner
        
        // y-axis
        var outer = CATransform3DIdentity
        outer.m34 = -1 / 500
        outer = CATransform3DRotate(outer, CGFloat.pi/4, 0, 1, 0)
        outerView.layer.transform = outer
        
        var inner = CATransform3DIdentity
        inner.m34 = -1 / 500
        inner = CATransform3DRotate(inner, -CGFloat.pi/4, 0, 1, 0)
        innerView.layer.transform = inner
        
    }
    
    func CGAffineTransformMakeShear(x: CGFloat, y: CGFloat) -> CGAffineTransform {
        var transform = CGAffineTransform.identity
        transform.c = -x
        transform.b = y
        
        return transform
    }
}

