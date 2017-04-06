//
//  ViewController.swift
//  Chap6_Specialized_Layers
//
//  Created by Joonwon Lee on 2/22/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit
import QuartzCore



class ViewController: UIViewController, CALayerDelegate {
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testTiledLayer()
        testEmitterLayer()
    }
    
    func testEmitterLayer() {
        let emitter = CAEmitterLayer()
        emitter.frame = containerView.bounds
        containerView.layer.addSublayer(emitter)
        
        // configure emitter
        emitter.renderMode = kCAEmitterLayerAdditive
        emitter.emitterPosition = CGPoint(x: emitter.frame.midX, y: emitter.frame.midY)
        
        // create a particle template
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "Spark.png")?.cgImage
        cell.birthRate = 150
        cell.lifetime = 4
        cell.color = UIColor.red.cgColor
        
        cell.alphaSpeed = -0.4
        cell.velocity = 50
        cell.velocityRange = 50
        cell.emissionRange = CGFloat.pi * 2
        
        emitter.emitterCells = [cell]
    }
    
    func testTiledLayer() {
        let tileLayer = CATiledLayer()
        tileLayer.frame = CGRect(x: 0, y: 0, width: 2048, height: 2048)
        tileLayer.delegate = self
        //        tileLayer.fadeDuration
        scrollView.layer.addSublayer(tileLayer)
        scrollView.contentSize = tileLayer.frame.size
        tileLayer.setNeedsDisplay()
    }
    
    func draw(_ layer: CALayer, in ctx: CGContext) {
        
        guard let tiledLayer = layer as? CATiledLayer else {
            print("no it is not tiledLayer")
            return
        }
        
        let bounds = ctx.boundingBoxOfClipPath
        let x = Int(bounds.origin.x / tiledLayer.tileSize.width)
        let y = Int(bounds.origin.y / tiledLayer.tileSize.height)
        
        // Retina Tiles > 요건 path에서 크래쉬 생김 (이유: 레티나로 하면 접근하는 x, y가 변경됨) 
//        let scale = UIScreen.main.scale
//        let x = Int(bounds.origin.x / tiledLayer.tileSize.width * scale)
//        let y = Int(bounds.origin.y / tiledLayer.tileSize.height * scale)
        
        // load image
        let imageName = String(format: "Snowman_%02i_%02i", x, y)
        let imagePath = Bundle.main.path(forResource: imageName, ofType: "jpg")
        let tileImage = UIImage(contentsOfFile: imagePath!)
        
        
        //draw tile 
        UIGraphicsPushContext(ctx)
        tileImage?.draw(in: bounds)
        UIGraphicsPopContext()
    }
}

