//
//  ViewController.swift
//  Chap4_Visual_Effect
//
//  Created by Joonwon Lee on 2/13/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var shadowView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        leftView.layer.cornerRadius = 20
//        rightView.layer.cornerRadius = 20
//        
//        leftView.layer.borderWidth = 5
//        rightView.layer.borderWidth = 5
//        
//        // add a shadow to left
//        leftView.layer.shadowOpacity = 0.5
//        leftView.layer.shadowOffset = CGSize(width: 0, height: 5)
//        leftView.layer.shadowRadius = 5
//        
//        // add same shadow to shadowView
//        shadowView.layer.shadowOpacity = 0.5
//        shadowView.layer.shadowOffset = CGSize(width: 0, height: 5)
//        shadowView.layer.shadowRadius = 5
//        
//        
//        rightView.layer.masksToBounds = true
        
        
        // shadow Property 
        leftView.layer.shadowOpacity = 0.5
        rightView.layer.shadowOpacity = 0.5
        
        
        let squarePath = CGMutablePath()
        squarePath.addRect(leftView.bounds)
        leftView.layer.shadowPath = squarePath
        
        let circlePath = CGMutablePath()
        circlePath.addEllipse(in: rightView.bounds)
        rightView.layer.shadowPath = circlePath
        
        
    }


}

