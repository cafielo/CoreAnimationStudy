//
//  ViewController.swift
//  chap14_imageLoading_benchmark
//
//  Created by Joon on 13/04/2017.
//  Copyright © 2017 Joon. All rights reserved.
//

import UIKit

let imageFolder = "Gradient Images"

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let items = ["2048x1536", "1024x768", "512x384", "256x192", "128x96", "64x48", "32x24"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ViewController {
    func loadImageForOneSec(path: String) -> CFTimeInterval {
        
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        
        // start timing
        var imageLoaded: CFTimeInterval = 0
        var endTime: CFTimeInterval = 0
        let startTime: CFTimeInterval = CFAbsoluteTimeGetCurrent()
        
        while endTime - startTime < 1 {
            // load image
            let image = UIImage(contentsOfFile: path)
            
            // decompress
            image?.draw(at: CGPoint.zero)
            
            // update
            imageLoaded += 1
            endTime = CFAbsoluteTimeGetCurrent()
        }
        
        UIGraphicsEndImageContext()
        
        let result = (endTime - startTime) / imageLoaded
        return result
    }
    
    func loadImage(at index: Int) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            let file = self.items[index]
            let pngPath = Bundle.main.path(forResource: file, ofType: "png", inDirectory: imageFolder)
            let jpgPath = Bundle.main.path(forResource: file, ofType: "jpg", inDirectory: imageFolder)
            
            
            //load
            let pngTime = self.loadImageForOneSec(path: pngPath!) * 1000
            let jpgTime = self.loadImageForOneSec(path: jpgPath!) * 1000
            
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: index, section: 0)
                let cell = self.tableView.cellForRow(at: indexPath)
                
                print(" p:\(pngTime),, j:\(jpgTime)")
                cell?.detailTextLabel?.text = String(format: "png: %03d ms   jpg: %03d ms", Int(pngTime), Int(jpgTime))
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = items[indexPath.row]
        cell?.detailTextLabel?.text = "Loading..."
        
        // laod image 
        loadImage(at: indexPath.row)
        
        return cell!
    }
}
