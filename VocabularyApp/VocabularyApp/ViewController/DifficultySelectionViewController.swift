//
//  DifficultySelectionViewController.swift
//  VocabularyApp
//
//  Created by Jun on 1/7/25.
//

import UIKit

class DifficultySelectionViewController: UIViewController {
    let colorClosure = { (action: UIAction) in
        print("hello")
    }
    @IBOutlet weak var difficultySelectionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var strings: [String] = ["alpha", "beta", "gamma"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
        button.menu = UIMenu(children: [
            UIAction(title: "B2", handler: colorClosure),
            UIAction(title: "C1", handler: colorClosure),
        ])
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
    }
    
    @objc func sayHello() {
        difficultySelectionLabel.text = "picked difficulty"
        descriptionLabel.text = "description"
    }

}

extension DifficultySelectionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "definitionVC")
        
        vc.navigationItem.title = strings[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
        
        print(strings[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("test")
        return strings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = strings[indexPath.row]
        
        print(cell)
        
        return cell
    }
    
    
}
