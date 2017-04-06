//
//  TransitionViewController.swift
//  Chap8_Explicit_Animations
//
//  Created by Joonwon Lee on 3/8/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit

class TransitionViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var images: [UIImage] = [UIImage(named: "Anchor")!, UIImage(named: "Cone")!, UIImage(named: "Igloo")!, UIImage(named: "Spaceship")!]

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = images.first
    }
    
    @IBAction func switchImage(_ sender: UIButton) {
        
        //----- CATransition -----
//        // set up crossfade transition
//        let transition = CATransition()
//        transition.type = kCATransitionFade
//        
//        // apply transition to imageview backing layer
//        imageView.layer.add(transition, forKey: nil)
//        
//        // cycle to next image
//        if var index = images.index(of: imageView.image!) {
//            index = index == images.count - 1 ? 0 : index + 1
//            imageView.image = images[index]
//        }
        
        //----- UIView transition ----
        UIView.transition(with: imageView, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: {

            // cycle to next image
            if var index = self.images.index(of: self.imageView.image!) {
                index = index == self.images.count - 1 ? 0 : index + 1
                self.imageView.image = self.images[index]
            }
        }, completion: nil)
    }
    
    @IBAction func performTransition(_ sender: UIButton) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let coverImage = UIGraphicsGetImageFromCurrentImageContext()
        
        let coverView = UIImageView(image: coverImage)
        coverView.frame = view.bounds
        view.addSubview(coverView)
        
        let red = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let green = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let blue = CGFloat(arc4random()) / CGFloat(UInt32.max)
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
        
        UIView.animate(withDuration: 1.0, animations: {
            
            // scale, rotate and fade the view
            var transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            transform = transform.rotated(by: CGFloat.pi/2)
            coverView.transform = transform
            coverView.alpha = 0.0

        }) { (bool) in
            coverView.removeFromSuperview()
        }
    }
}
