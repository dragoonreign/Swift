//
//  DefinitionViewController.swift
//  VocabularyApp
//
//  Created by Jun on 1/7/25.
//

import Foundation
import UIKit

class DefinitionViewController: UIViewController {
    //drag the label here
    // weak label here
    
    var text: String?
    
    override func viewDidLoad() {
        if text != nil {
            label.text = text
    }
}
