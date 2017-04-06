//
//  ViewController.swift
//  Chap12_TuningForSpeed
//
//  Created by Joonwon Lee on 4/2/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var items = [[String: Any]]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up data
        setUpData()
        tableView.reloadData()
    }
    
    func setUpData() {
        for _ in 0..<1000 {
            let dic = ["name": randomName(), "image": randomAvatar()] as [String : Any]
            items.append(dic)
        }
    }
    
    func randomName() -> String {
        let first = ["Alice", "Bob", "Bill", "Charles", "Dan", "Dave", "Ethan", "Frank"]
        let last = ["Appleased", "Bandicoot", "Caravan", "Dabble", "Ernest", "Fortune"]
        let idx1 = Int(arc4random_uniform(UInt32(first.count)))
        let idx2 = Int(arc4random_uniform(UInt32(last.count)))
        return "\(first[idx1]) \(last[idx2])"
    }
    
    func randomAvatar() -> UIImage {
        let images = [#imageLiteral(resourceName: "Snowman"), #imageLiteral(resourceName: "Igloo"), #imageLiteral(resourceName: "Cone"), #imageLiteral(resourceName: "Spaceship"), #imageLiteral(resourceName: "Anchor"), #imageLiteral(resourceName: "Key")]
        let randomIdx = Int(arc4random_uniform(UInt32(images.count)))
        return images[randomIdx]
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemCell
        
        let dic: [String: Any] = items[indexPath.row]
        cell.caImageView.image = dic["image"] as? UIImage
        cell.caLabel.text = dic["name"] as? String
        
        //set image shadow
        cell.caImageView.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.caImageView.layer.shadowOpacity = 0.75
        cell.clipsToBounds = true
        
        
        //set text shadow
        cell.caLabel.backgroundColor = UIColor.clear
        cell.caLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.caLabel.layer.shadowOpacity = 0.5
        
        //rasterize
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        return cell
    }
}

class ItemCell: UITableViewCell {
    @IBOutlet weak var caImageView: UIImageView!
    @IBOutlet weak var caLabel: UILabel!
}
