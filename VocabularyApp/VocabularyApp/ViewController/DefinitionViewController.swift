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
    var definitions = [Word.Definitions]()
    typealias CompletionHandler = (_ success: Bool) -> Void
    
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var characters = ["alpha", "beta", "gamma"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getWord(word: text ?? " ")  //prints out got the word if fetch async is successful
        
        tableView.dataSource = self
        
        
    }
    
    func setUpTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "definitionCell")
    }
    
    func displayDefinition() {
        print("got the word successfully and displaying information to the screen")
        
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        setUpTableView()
        
//        if words.count > 0 {
//            label.text = words[0].word
//        }
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
                        self.words = [decodedUsers[0]]
                        self.definitions = (decodedUsers[0].meanings?[0].definitions)!
                        print(self.definitions)
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

extension DefinitionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return definitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "definitionCell", for: indexPath)
        cell.textLabel?.text = definitions[indexPath.row].definition
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell
    }
}
