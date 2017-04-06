//
//  SolidObjectsViewController.swift
//  Chap5_transforms
//
//  Created by Joonwon Lee on 2/19/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit

import GLKit

class SolidObjectsViewController: UIViewController {
    
    let lightDirection:(Float, Float, Float) = (0.0, 1.0, -0.5)
    let ambientLight: Double = 0.5
    
    
    @IBOutlet var faces: [UIView]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // set up the container sublayer transform
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500.0
        
        perspective = CATransform3DRotate(perspective, -CGFloat.pi/4, 1, 0, 0)
        perspective = CATransform3DRotate(perspective, -CGFloat.pi/4, 0, 1, 0)
        view.layer.sublayerTransform = perspective
        
        
        // add cube face1
        var transform = CATransform3DMakeTranslation(0, 0, 100)
        addFace(index: 0, transForm: transform)
        
        // add cube face2
        transform = CATransform3DMakeTranslation(100, 0, 0)
        transform = CATransform3DRotate(transform, CGFloat.pi/2, 0, 1, 0)
        addFace(index: 1, transForm: transform)
        
        
        // add cube face3
        transform = CATransform3DMakeTranslation(0, -100, 0)
        transform = CATransform3DRotate(transform, CGFloat.pi/2, 1, 0, 0)
        addFace(index: 2, transForm: transform)
        
        // add cube face4
        transform = CATransform3DMakeTranslation(0, 100, 0)
        transform = CATransform3DRotate(transform, -CGFloat.pi/2, 1, 0, 0)
        addFace(index: 3, transForm: transform)
        
        // add cube face5
        transform = CATransform3DMakeTranslation(-100, 0, 0)
        transform = CATransform3DRotate(transform, -CGFloat.pi/2, 0, 1, 0)
        addFace(index: 4, transForm: transform)
        
        
        // add cube face6
        transform = CATransform3DMakeTranslation(0, 0, -100)
        transform = CATransform3DRotate(transform, CGFloat.pi, 0, 1, 0)
        addFace(index: 5, transForm: transform)
    }
    
    func applyLightingToFace(face: CALayer) {
        let darkLayer = CALayer()
        darkLayer.frame = face.bounds
        darkLayer.backgroundColor = UIColor.blue.cgColor
        
        face.addSublayer(darkLayer)
//
//        // convert the face transform to matrix
        let transform = face.transform
        let matrix4: GLKMatrix4 = GLKMatrix4(m: (Float(transform.m11), Float(transform.m12), Float(transform.m13), Float(transform.m14), Float(transform.m21), Float(transform.m22), Float(transform.m23), Float(transform.m24), Float(transform.m31), Float(transform.m32), Float(transform.m33), Float(transform.m34), Float(transform.m41), Float(transform.m42), Float(transform.m43), Float(transform.m44)))
        let matrrix3: GLKMatrix3 = GLKMatrix4GetMatrix3(matrix4)
//        print ("---\(matrrix3.m) --- \(matrix4.m)")
        
        
//        //get face normal
        var normal = GLKVector3(v: (0, 0, 1))
        normal = GLKMatrix3MultiplyVector3(matrrix3, normal)
        normal = GLKVector3Normalize(normal)
        
//        //get dot product with light direction
        let light = GLKVector3Normalize(GLKVector3(v: lightDirection))
        let dotProduct = GLKVector3DotProduct(light, normal)
        
//        // set lighting layer opacity
        let shadow = 1 + Double(dotProduct) - ambientLight
        
        let color = UIColor.black.withAlphaComponent(CGFloat(shadow))
        darkLayer.backgroundColor = color.cgColor
        
    }

    func addFace(index: Int, transForm:CATransform3D) {
        
        view.addSubview(faces[index])
        faces[index].center = view.center
        faces[index].layer.transform = transForm
        applyLightingToFace(face: faces[index].layer)
    }
  

}
