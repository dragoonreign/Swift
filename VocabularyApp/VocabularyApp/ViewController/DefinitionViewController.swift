//
//  DefinitionViewController.swift
//  VocabularyApp
//
//  Created by Jun on 1/7/25.
//

import UIKit

class DefinitionViewController: UIViewController {
    //drag the label here
    @IBOutlet weak var label: UILabel!
    var text: String?
    var words = [Word]()
    typealias CompletionHandler = (_ success: Bool) -> Void
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getWord(word: text ?? " ")  //prints out got the word if fetch async is successful
    }
    
    func displayDefinition() {
        print("got the word successfully and displaying information to the screen")
        
        if words.count > 0 {
            label.text = words[0].word
        }
        
        
    }
    
    func getWord(word: String) {
        guard let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)") else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedUsers = try JSONDecoder().decode([Word].self, from: data)
                        self.words.removeAll()
                        self.words.append(decodedUsers[0])
//                        self.words = [decodedUsers[0]]
                        self.displayDefinition()
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
    }
}
