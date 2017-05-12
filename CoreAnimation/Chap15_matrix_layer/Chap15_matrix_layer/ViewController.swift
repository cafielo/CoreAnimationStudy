//
//  ViewController.swift
//  Chap15_matrix_layer
//
//  Created by Joon on 16/04/2017.
//  Copyright © 2017 Joon. All rights reserved.
//

import UIKit



let width = 100
let height = 100
let depth = 10

let viewSize: CGFloat = 100
let spacing = 150

let camera_distance: CGFloat = 500
func perspective(z: CGFloat) -> CGFloat {
    return camera_distance / (z + camera_distance)
}

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var recycleSet = Set<CALayer>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: (width - 1) * spacing, height: (height - 1) * spacing)
        
        var transform = CATransform3DIdentity
        transform.m34 =  -1 / camera_distance
        print (transform.m34)
        scrollView.layer.sublayerTransform = transform
        
        
    }
    
    override func viewDidLayoutSubviews() {
        updateLayers()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateLayers()
    }
    
    
    func updateLayers() {
        var bounds = scrollView.bounds
        bounds.origin = scrollView.contentOffset
        bounds = bounds.insetBy(dx: -viewSize / 2, dy: -viewSize / 2)
        
        // add existing layers to pool
        scrollView.layer.sublayers?.forEach {
            recycleSet.insert($0)
        }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        var recycled = 0
        
        // create layers
        var visibleLayers = [CALayer]()
        
        for z in (0..<depth).reversed() {
            
            // increase bounds size to compensate for perspective
            var adjusted = bounds
            adjusted.size.width /= perspective(z: CGFloat(z * spacing))
            adjusted.size.height /= perspective(z: CGFloat(z * spacing))
            adjusted.origin.x -= (adjusted.size.width - bounds.size.width)/2
            adjusted.origin.y -= (adjusted.size.height - bounds.size.height)/2
            
            for y in 0..<height {
                if CGFloat(y * spacing) < adjusted.origin.y || CGFloat(y * spacing) >= adjusted.origin.y + adjusted.size.height {
                    continue
                }
                
                for x in 0..<width {
                    if CGFloat(x * spacing) < adjusted.origin.x || CGFloat(x * spacing) >= adjusted.origin.x + adjusted.size.width {
                        continue
                    }
                    
                    var layer: CALayer?
                    layer = recycleSet.first
//
                    if layer != nil {
                        recycled += 1
                        recycleSet.remove(layer!)
                    } else {
                        layer = CALayer()
                        layer?.frame = CGRect(x: 0, y: 0, width: viewSize, height: viewSize)
                        layer?.position = CGPoint(x: x * spacing, y: y * spacing)
                        layer?.zPosition = CGFloat(-z * spacing)
                    }
                    let alpha = 1 - CGFloat(z) * 1 / CGFloat(depth)
                    layer?.backgroundColor = UIColor.white.withAlphaComponent(alpha).cgColor
                    visibleLayers.append(layer!)

                    
//                    let layer = CALayer()
//                    layer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//                    layer.position = CGPoint(x: x * spacing, y: y * spacing)
//                    layer.zPosition = CGFloat(-z * spacing)
//                    let alpha = 1 - CGFloat(z) * 1 / CGFloat(depth)
//                    print(alpha)
//                    
//                    layer.backgroundColor = UIColor.white.withAlphaComponent(alpha).cgColor
//                    visibleLayers.append(layer)
                }
            }
        }
        CATransaction.commit()
        scrollView.layer.sublayers = visibleLayers
        
    

    


    }
}

