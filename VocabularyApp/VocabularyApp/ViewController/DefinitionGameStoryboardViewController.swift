//
//  DefinitionGameStoryboardViewController.swift
//  VocabularyApp
//
//  Created by Jun on 1/16/25.
//

import UIKit

class DefinitionGameStoryboardViewController: UIViewController {
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    var words: [Word] = []
    var answerIndex: Int = 0
    var correctWord = ""
    
    var runs: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startGame()
    }
    
    func startGame() {
        words = words.shuffled()
        
        answerIndex = Int.random(in: 0..<words.count-1)
        correctWord = words[answerIndex].word
        definitionLabel.text = words[answerIndex].meanings![0].definitions![0].definition
        
        button1.setTitle(words[0].word, for: .normal)
        button2.setTitle(words[1].word, for: .normal)
        button3.setTitle(words[2].word, for: .normal)
        button4.setTitle(words[3].word, for: .normal)
    }
    
    func resetGame() {
        runs = 0
        startGame()
    }
    
    func goToNextGameMode() {
        var storyboard: UIStoryboard!
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "spellingGameVC") as! SpellingGameViewController
        vc.words = words
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        if sender.titleLabel?.text == correctWord {
            print("Correct!")
            
            if runs < 1 {
                runs += 1
                startGame()
            } else {
                resetGame()
                print("To the next game!")
                goToNextGameMode()
            }
        } else {
            print("Incorrect!")
        }
    }
}
