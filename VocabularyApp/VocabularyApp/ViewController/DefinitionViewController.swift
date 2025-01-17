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
    
    var selectedWords: [String]?
    var text: String?
    var words = [Word]()
    var meanings = [Word.Meanings]()
    var definitions = [Word.Definitions]()
    typealias CompletionHandler = (_ success: Bool) -> Void
    
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var characters = ["alpha", "beta", "gamma"]
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.setContentHuggingPriority(.required, for: .horizontal)
        stack.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return stack
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        
        scrollView.addSubview(stackView)
//        stackView.heightAnchor.constraint(equalToConstant: view.frame.height - 100).isActive = true
//        stackView.widthAnchor.constraint(equalToConstant: view.frame.width - 50).isActive = true
//        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
        ])
        
        let button: UIButton = {
            let button = UIButton(type: .system)
            button.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
            button.setTitle( "Start", for: .normal)
            button.tintColor = .label
            button.backgroundColor = .red
    //        button.center = testLabel.center
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(goToDefinitionGame), for: .touchUpInside)
            return button
        }()
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            button.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
//            button.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
//            button.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
        ])
        
        
        
        for element in selectedWords ?? [] {
            getWord(word: element)  //prints out got the word if fetch async is successful
        }
        
//        tableView.dataSource = self
        
        
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
        
        print(words.count)
        
        let wordStackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
//            stack.distribution = .fill
            stack.spacing = 10
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.backgroundColor = UIColor.random()
            stack.setContentHuggingPriority(.required, for: .horizontal)
            stack.setContentCompressionResistancePriority(.required, for: .horizontal)
            return stack
        }()
        
        let myIndex = words.count - 1
        
        let pageLabel = UILabel()
        let wordLabel = UILabel()
        let definitionLabel = UILabel()
        
        pageLabel.text = "Definition"
        wordLabel.text = words[myIndex].word
        wordLabel.lineBreakMode = .byWordWrapping
        wordLabel.numberOfLines = 0
        definitionLabel.text = words[myIndex].meanings![0].definitions![0].definition
        definitionLabel.lineBreakMode = .byWordWrapping
        definitionLabel.numberOfLines = 0
            
        wordStackView.addArrangedSubview(wordLabel)
        wordStackView.addArrangedSubview(pageLabel)
        wordStackView.addArrangedSubview(definitionLabel)
        
        stackView.addArrangedSubview(wordStackView)
        
//        view.backgroundColor = .white
//        safeArea = view.layoutMarginsGuide
//        setUpTableView()
        
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
                        if self.words.count >= 5 {
                            self.words.removeAll()
                        }
                        self.words.append(decodedUsers[0])
                        self.meanings.append((decodedUsers[0].meanings?[0])!)
                        self.definitions = (decodedUsers[0].meanings?[0].definitions)!
                        self.displayDefinition()
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
    }
    
    @objc func goToDefinitionGame() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "definitionGameStoryboardVC") as! DefinitionGameStoryboardViewController
        
        vc.words = words
        
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
}

//extension DefinitionViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return definitions.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "definitionCell", for: indexPath)
//        cell.textLabel?.text = definitions[indexPath.row].definition
//        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
//        cell.textLabel?.numberOfLines = 0
//        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Definitions"
//    }
//}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
    }
}
