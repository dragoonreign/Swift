//
//  SynonymGameViewController.swift
//  VocabularyApp
//
//  Created by Jun on 1/15/25.
//

import UIKit

class SynonymGameViewController: UIViewController {
    @IBOutlet weak var synonymWordLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    
    var randomInts: [Int] = []
    var wrongInts: [Int] = []
    
    var words: [Word] = []
    
    var answerIndex: Int = 0
    var correctWord = ""
    
    var runs: Int = 0
    
    var synonymIntTracker: Int = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        startGame()
    }
    

    func startGame() {
        //shuffle the array
        words = words.shuffled()
        
        answerIndex = Int.random(in: 0..<words.count-1)
        correctWord = words[answerIndex].word
        
        let synonymCount = words[answerIndex].meanings![0].synonyms!.count
        synonymWordLabel.text = "Select \(synonymCount) synonyms of \(correctWord)"
        
        if synonymCount >= 1 {
            updateCorrectButtonInformation()
            updateWrongButtonInformation()
        }
    
        print(randomInts)
        print(wrongInts)
    }
    
    func updateCorrectButtonInformation() {
        let synonymCount = words[answerIndex].meanings![0].synonyms!.count
        
        while randomInts.count < synonymCount {
            let randomInt = Int.random(in: 1..<words.count)
            if (!randomInts.contains(randomInt)) {
                randomInts.append(randomInt)
            }
        }
        
        for i in 0..<randomInts.count-1 {
            switch randomInts[i] {
            case 1:
                button1.setTitle(words[answerIndex].meanings![0].synonyms![i], for: .normal)
            case 2:
                button2.setTitle(words[answerIndex].meanings![0].synonyms![i], for: .normal)
            case 3:
                button3.setTitle(words[answerIndex].meanings![0].synonyms![i], for: .normal)
            case 4:
                button4.setTitle(words[answerIndex].meanings![0].synonyms![i], for: .normal)
            case 5:
                button5.setTitle(words[answerIndex].meanings![0].synonyms![i], for: .normal)
            case 6:
                button6.setTitle(words[answerIndex].meanings![0].synonyms![i], for: .normal)
            default:
                break
            }
        }
    }
    
    func updateWrongButtonInformation() {
        let synonymCount = words[answerIndex].meanings![0].synonyms!.count
        
        //keep track of synonymCount for the wrong answers
        synonymIntTracker = synonymIntTracker - synonymCount
        
        var wrongAnswerIndex = Int.random(in: 0..<words.count-1)
        
        //keep track of synonymCount for the wrong answers
        while wrongInts.count < synonymIntTracker {
            let randomInt = Int.random(in: 1..<words.count)
            if !randomInts.contains(randomInt) && !wrongInts.contains(randomInt){
                wrongInts.append(randomInt)
            }
        }
        
        while wrongAnswerIndex == answerIndex {
            wrongAnswerIndex = Int.random(in: 0..<words.count-1)
        }
        
        //give buttons title synonyms.
        for i in 0..<wrongInts.count-1 {
            switch wrongInts[i] {
            case 1:
                button1.setTitle(words[wrongAnswerIndex].meanings![0].synonyms![i], for: .normal)
            case 2:
                button2.setTitle(words[wrongAnswerIndex].meanings![0].synonyms![i], for: .normal)
            case 3:
                button3.setTitle(words[wrongAnswerIndex].meanings![0].synonyms![i], for: .normal)
            case 4:
                button4.setTitle(words[wrongAnswerIndex].meanings![0].synonyms![i], for: .normal)
            case 5:
                button5.setTitle(words[wrongAnswerIndex].meanings![0].synonyms![i], for: .normal)
            case 6:
                button6.setTitle(words[wrongAnswerIndex].meanings![0].synonyms![i], for: .normal)
            default:
                break
            }
        }
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        print(sender.titleLabel?.text ?? "")
    }
    
}
