//
//  ViewController.swift
//  chap13_Efficient_drawing
//
//  Created by Joonwon Lee on 4/5/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController {
    
    @IBOutlet weak var drawingView: DrawingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}

let brushSize: CGFloat = 32

class DrawingView: UIView {
    
    var path: UIBezierPath?
    
    var strokes = [CGPoint]()
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    override func awakeFromNib() {
        path = UIBezierPath()
        //13.1
//        path?.lineJoinStyle = .round
//        path?.lineCapStyle = .round
//        path?.lineWidth = 5
        
        //13.2
//        let shapeLayer = self.layer as! CAShapeLayer
//        shapeLayer.strokeColor = UIColor.red.cgColor
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.lineJoin = kCALineJoinRound
//        shapeLayer.lineCap = kCALineCapRound
//        shapeLayer.lineWidth = 5
        
        //13.3
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point =  touches.first?.location(in: self) else {
            return
        }
        //13.2
//        path?.move(to: point)
        
        addBrushStroke(at: point)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point =  touches.first?.location(in: self) else {
            return
        }
        
//        13.2
//        guard let shapeLayer = self.layer as? CAShapeLayer else { return }
//        path?.addLine(to: point)
//        shapeLayer.path = path?.cgPath
        
//        setNeedsDisplay()
        
        addBrushStroke(at: point)
    }
    
    func addBrushStroke(at point: CGPoint) {
        strokes.append(point)

        //        setNeedsDisplay()
        setNeedsDisplay(brushRect(of: point))
    }
    
    func brushRect(of point: CGPoint) -> CGRect {
        return CGRect(x: point.x - brushSize/2, y: point.y - brushSize/2, width: brushSize, height: brushSize)
    }
    
    override func draw(_ rect: CGRect) {
        
        for point in strokes {
            let brushRect = CGRect(x: point.x - brushSize/2, y: point.y - brushSize/2, width: brushSize, height: brushSize)
            #imageLiteral(resourceName: "Chalk").draw(in: brushRect)
            
        }
        
        //13.2
//        UIColor.clear.setFill()
//        path?.fill()
//
//        UIColor.red.setStroke()
//        path?.stroke()
    }
}

