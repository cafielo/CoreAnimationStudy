//
//  MaskViewController.swift
//  Chap4_Visual_Effect
//
//  Created by Joonwon Lee on 2/13/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit

class MaskViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet var digitViews: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let maskLayer = CALayer()
//        maskLayer.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//        let maskImage = UIImage(named: "star")
//        maskLayer.contents = maskImage?.cgImage
//        imageView.layer.mask = maskLayer
        
        setupDigitViews()
        
    }

    func setupDigitViews() {
        let digitsImage = UIImage(named: "Digits")?.cgImage
        
        digitViews.forEach { view in
            view.layer.contents = digitsImage
            view.layer.contentsRect = CGRect(x: 0, y: 0, width: 0.1, height: 1.0)
            view.layer.contentsGravity = kCAGravityResizeAspect
            view.layer.magnificationFilter = kCAFilterNearest
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.tick()
        }
    }
    
    func setDigit(digit: Int, forView view: UIView) {
        view.layer.contentsRect = CGRect(x: CGFloat(digit) * 0.1, y: 0, width: 0.1, height: 1.0)
    }
    
    func tick() {
        
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        setDigit(digit: hour / 10, forView: digitViews[0])
        setDigit(digit: hour % 10, forView: digitViews[1])
        
        setDigit(digit: minutes / 10, forView: digitViews[2])
        setDigit(digit: minutes % 10, forView: digitViews[3])
        
        setDigit(digit: seconds / 10, forView: digitViews[4])
        setDigit(digit: seconds % 10, forView: digitViews[5])
    }
    
}
