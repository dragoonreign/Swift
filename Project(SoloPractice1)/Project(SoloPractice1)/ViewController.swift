//
//  ViewController.swift
//  Project(SoloPractice1)
//
//  Created by Jun on 12/31/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var _image: UIImageView!
    @IBOutlet var _button1: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        _image.image = UIImage(named: "US")
        
        _button1.setImage(UIImage(named: "US"), for: .normal)
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        print("Button tapped with tag \(sender.tag)")
    }
    
}

