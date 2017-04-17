//
//  ViewController.swift
//  chap14_hybrid_image
//
//  Created by Joon on 13/04/2017.
//  Copyright © 2017 Joon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "Snowman.jpg")
        let mask = UIImage(named: "SnowmanMask.png")
        
        // convert mask to correct format
        let graySpace = CGColorSpaceCreateDeviceGray()
        let maskRef = mask!.cgImage!.copy(colorSpace: graySpace)
        
        
        // combine images
        let resultRef = image!.cgImage!.masking(maskRef!)
        let result = UIImage(cgImage: resultRef!)
        
        imageView.image = result
        
    }

    
}

