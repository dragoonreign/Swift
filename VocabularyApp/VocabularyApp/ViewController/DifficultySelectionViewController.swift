//
//  DifficultySelectionViewController.swift
//  VocabularyApp
//
//  Created by Jun on 1/7/25.
//

import UIKit

class DifficultySelectionViewController: UIViewController {
    private var allWords = [String]()
    private var b2Vocab = [String]()
    private var c1Vocab = [String]()
    private var vocab = ""
    private var partOfSpeech = ""
    
    let colorClosure = { (action: UIAction) in
        print("hello")
    }
    @IBOutlet weak var difficultySelectionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startGame()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
//        button.menu = UIMenu(children: [
//            UIAction(title: "B2", handler: colorClosure),
//            UIAction(title: "C1", handler: colorClosure),
//        ])
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
    }
    
    @objc func OnButtonDifficultySelected() {
        difficultySelectionLabel.text = "picked difficulty"
        descriptionLabel.text = "description"
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        OnButtonDifficultySelected()
        tableView.reloadData()
    }
    
    
    func startGame() {
        //1. Find the url for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "vocabList", withExtension: "txt") {
            //2. load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. split the string up into an array of strings, splitting on line breaks
                allWords = startWords.components(separatedBy: "\n")
                var newArray = [String]()
                for word in allWords {
                    newArray.append(word.components(separatedBy: " ")[0])
                }
                b2Vocab = Array(newArray[1..<newArray.firstIndex(of: "C1")!])
                c1Vocab = Array(newArray[newArray.firstIndex(of: "C1")!+1..<newArray.count - 1])
                //4. pick on random word, or use "silkworm" as a sensible default
                let vocabWordArr = allWords.randomElement()?.components(separatedBy: " ")
                vocab = vocabWordArr?[0] ?? "error"
                partOfSpeech = vocabWordArr?[1] ?? "error"
//                if vocabWordArr?.count >= 2 {
//                    partOfSpeech = vocabWordArr?[1] ?? "error"
//                }
                
                //if we are here everything has worked, so we can exit
                return
            }
        }
        
        // if we are here then there was a problem - trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }

}

extension DifficultySelectionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "definitionVC") as! DefinitionViewController

        //update the text variable tand the nav title.
        switch button.titleLabel?.text {
        case "B2":
            vc.text = b2Vocab[indexPath.row]
            vc.navigationItem.title = b2Vocab[indexPath.row]
        case "C1":
            vc.text = c1Vocab[indexPath.row]
            vc.navigationItem.title = c1Vocab[indexPath.row]
        default:
            print("empty")
        }
        
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch button.titleLabel?.text {
        case "B2":
            return b2Vocab.count
        case "C1":
            return c1Vocab.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch button.titleLabel?.text {
        case "B2":
            cell.textLabel?.text = b2Vocab[indexPath.row]
        case "C1":
            cell.textLabel?.text = c1Vocab[indexPath.row]
        default:
            print("error in table view cell for row at")
        }
        
        return cell
    }
    
    
}
