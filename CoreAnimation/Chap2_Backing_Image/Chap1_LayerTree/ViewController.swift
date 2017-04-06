//
//  ViewController.swift
//  Chap1_LayerTree
//
//  Created by Joonwon Lee on 2/1/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit
import QuartzCore
import CoreGraphics

class ViewController: UIViewController, CALayerDelegate {

    @IBOutlet weak var layerView: UIView!
    
    
    @IBOutlet weak var upperLeft: UIView!
    @IBOutlet weak var upperRight: UIView!
    @IBOutlet weak var lowerLeft: UIView!
    @IBOutlet weak var lowerRight: UIView!
    
    @IBOutlet weak var button1: UIView!
    @IBOutlet weak var button2: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blueLayer = CALayer()
        blueLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        blueLayer.backgroundColor = UIColor.blue.cgColor
        
        
        // --- custom draw 실습 ----
        //set controller as layer delegate
        blueLayer.delegate = self
        
        // ensure that layer backing image uses correct scale
        blueLayer.contentsScale = UIScreen.main.scale
        
        //add layer to our view
        layerView.layer.addSublayer(blueLayer)
        
        // force layer to redraw
        blueLayer.display()
        
    
        //load an image
        let image = UIImage(named: "jennifer")
        
        // bridge 안해도 되넹
        layerView.layer.contents = image?.cgImage
        
        layerView.layer.contentsGravity = kCAGravityCenter
        // 이거 안하니 이미지가 왕 큼
        layerView.layer.contentsScale = image!.scale
        
        
        // ---- contentRect 실습 -----
        
        let sImage = UIImage(named: "spriteImage")
        
        addSpriteImage(sImage!, CGRect(x: 0, y: 0, width: 0.5, height: 0.5), upperLeft.layer)
        addSpriteImage(sImage!, CGRect(x: 0.5, y: 0, width: 0.5, height: 0.5), upperRight.layer)
        addSpriteImage(sImage!, CGRect(x: 0, y: 0.5, width: 0.5, height: 0.5), lowerLeft.layer)
        addSpriteImage(sImage!, CGRect(x: 0.5, y: 0.5, width: 0.5, height: 0.5), lowerRight.layer)
        
        
        // ------ contentCenter 실습 ---- ??
        let strechableImage = UIImage(named: "strechable")
        
        addStrechableImage(strechableImage!, CGRect(x: 0.25, y: 0.25, width: 0.5, height: 0.5), button1.layer)
        addStrechableImage(strechableImage!, CGRect(x: 0.25, y: 0.25, width: 0.5, height: 0.5), button2.layer)
        
    }
    
    func addSpriteImage(_ image: UIImage,_ rect: CGRect, _ layer: CALayer) {
        //set Image 
        layer.contents = image.cgImage
        
        // scale contents to fit
        layer.contentsGravity = kCAGravityResizeAspect
        
        // set contentsRect  
        layer.contentsRect = rect
        
    }
    
    func addStrechableImage(_ image: UIImage,_ rect: CGRect, _ layer: CALayer) {
        //set Image
        layer.contents = image.cgImage
        
        // scale contents to fit
        layer.contentsGravity = kCAGravityResizeAspect
        
        // set contentsRect
        layer.contentsRect = rect
    }
    
    func draw(_ layer: CALayer, in ctx: CGContext) {
        ctx.setLineWidth(20)
        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.strokeEllipse(in: layer.bounds)
        
    }
}

