//
//  ViewController.swift
//  chap14_ImageIO
//
//  Created by Joonwon Lee on 4/8/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imagePaths: [String] {
        return Bundle.main.paths(forResourcesOfType: "png", inDirectory: "Vacation Photos")
//        return Bundle.main.paths(forResourcesOfType: <#T##String?#>, inDirectory: <#T##String?#>)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imagePaths.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCell
        
        // 14.1
//        let image = UIImage(contentsOfFile: imagePaths[indexPath.row])
//        cell.photo.image = image
        
        // 14.2
//        cell.tag = indexPath.row
//        cell.photo.image = nil
//        
//        DispatchQueue.global(qos: .background).async {
//            let image = UIImage(contentsOfFile: self.imagePaths[indexPath.row])
//            DispatchQueue.main.async {
//                cell.photo.image = image
//            }
//        }
        
        // 14.3
//        DispatchQueue.global(qos: .background).async {
//            // load image
//            let path = self.imagePaths[indexPath.row]
//            var image = UIImage(contentsOfFile: path)
//            
//            // redraw image using device context
//            UIGraphicsBeginImageContextWithOptions(cell.photo.bounds.size, true, 0)
//            image?.draw(in: cell.photo.bounds)
//            image = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            
//            // set image on main thread, but only if index still matches up
//            DispatchQueue.main.async {
//                cell.photo.image = image
//            }
//        }
        
        
        // 14.4
        //add the tiled layer
        var tileLayer = cell.contentView.layer.sublayers?.last as? CATiledLayer
        
        if tileLayer == nil {
            tileLayer = CATiledLayer()
            tileLayer?.frame = cell.bounds
            let scale = UIScreen.main.scale
            tileLayer?.contentsScale = scale
            tileLayer?.tileSize = CGSize(width: cell.bounds.size.width * scale, height: cell.bounds.size.height * scale)
            tileLayer?.delegate = self
            tileLayer?.setValue(indexPath.row, forKey: "index")
            cell.contentView.layer.addSublayer(tileLayer!)

        }
        
        tileLayer?.contents = nil
        tileLayer?.setValue(indexPath.row, forKey: "index")
        tileLayer?.setNeedsDisplay()
        
        return cell
    }
}

extension ViewController: CALayerDelegate {
    func draw(_ layer: CALayer, in ctx: CGContext) {
        // 14.4
        guard let index = layer.value(forKey: "index") as? Int else {
            return
        }
        let path = imagePaths[index]
        let image = UIImage(contentsOfFile: path)
        
        
        let aspectRatio = image!.size.height / image!.size.width
        var imageRect = CGRect.zero
        imageRect.size.width = layer.bounds.width
        imageRect.size.height = layer.bounds.height * aspectRatio
        imageRect.origin.y = (layer.bounds.size.height - imageRect.size.height)/2
        
        // draw tile
        UIGraphicsPushContext(ctx)
        image?.draw(in: imageRect)
        UIGraphicsPopContext()
    }
}


class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var photo: UIImageView!
}
