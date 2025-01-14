//
//  ViewController.swift
//  Project1(Swift)
//
//  Created by Jun on 12/23/24.
//

import Foundation
import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                //this is a picture to load
                pictures.append(item)
            }
        }
        
        print(pictures)
    }
}
