//
//  SpellingGameViewController.swift
//  VocabularyApp
//
//  Created by Jun on 1/11/25.
//

import UIKit

class SpellingGameViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var wordDefinition: UILabel!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    let answer = "hello"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        //get a random number within the answer string
        let randomLetterInAnswer = Int.random(in: 0..<answer.count)
        
        //empty the label text
        hintLabel.text = ""
        //replace all letter with underscore
        for (i, ele) in answer.enumerated() {
            if (randomLetterInAnswer != i) {
                hintLabel.text! += "_ "
            } else {
                hintLabel.text! += "\(ele) "
            }
        }
    }
    
    @objc func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        notificationLabel.text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        return true
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("correct")
        if answer == textField.text {
            notificationLabel.text = "Correct!"
        } else {
            notificationLabel.text = "Incorrect try again!"
        }
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
}
