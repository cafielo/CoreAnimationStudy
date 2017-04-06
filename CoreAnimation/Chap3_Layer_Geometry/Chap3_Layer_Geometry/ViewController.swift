//
//  ViewController.swift
//  Chap3_Layer_Geometry
//
//  Created by Joonwon Lee on 2/8/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var hourHandImageView: UIImageView!
    @IBOutlet weak var minuteHandImageView: UIImageView!
    @IBOutlet weak var secondHandImageView: UIImageView!
    
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var redView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hourHandImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        minuteHandImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        secondHandImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.tick()
        }
        
        greenView.layer.zPosition = 1.0
    }
}

extension ViewController {
    
    func tick() {
        let calendar = Calendar(identifier: .gregorian)
        let timeTuple = (
            calendar.component(.hour, from: Date()),
            calendar.component(.minute, from: Date()),
            calendar.component(.second, from: Date())
        )
        
        let hoursAngle = Double(timeTuple.0) / 12.0 * Double.pi * 2.0
        let minsAngle = Double(timeTuple.1) / 60.0 * Double.pi * 2.0
        let secsAngle = Double(timeTuple.2) / 60.0 * Double.pi * 2.0
        
        hourHandImageView.transform = CGAffineTransform(rotationAngle: CGFloat(hoursAngle))
        minuteHandImageView.transform = CGAffineTransform(rotationAngle: CGFloat(minsAngle))
        secondHandImageView.transform = CGAffineTransform(rotationAngle: CGFloat(secsAngle))
    }
}

