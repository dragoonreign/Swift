//
//  DefinitionGameViewController.swift
//  VocabularyApp
//
//  Created by Jun on 1/16/25.
//

import UIKit

class DefinitionGameViewController: UIViewController {
    let testLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    let button = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setUpLabel()
//        setUpButtons()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func setUpLabel() {
        testLabel.center = view.center
        testLabel.textAlignment = .center
        testLabel.text = "definition game"
        
        view.addSubview(testLabel)
    }
    
    func setUpButtons() {
        let hStackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.spacing = 1
            stack.translatesAutoresizingMaskIntoConstraints = false
//            stack.setContentHuggingPriority(.required, for: .horizontal)
//            stack.setContentCompressionResistancePriority(.required, for: .horizontal)
            return stack
        }()
        
        let vStackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.distribution = .fillEqually
            stack.spacing = 0
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.setContentHuggingPriority(.required, for: .horizontal)
            stack.setContentCompressionResistancePriority(.required, for: .horizontal)
            return stack
        }()
        
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        button.setTitle( "Start", for: .normal)
        button.tintColor = .label
        button.backgroundColor = .red
//        button.center = testLabel.center
        button.translatesAutoresizingMaskIntoConstraints = false
        
//        button.topAnchor.constraint(equalTo: testLabel.topAnchor).isActive = true
        
        view.addSubview(vStackView)
        //vstack first
        vStackView.addArrangedSubview(hStackView)
        
        NSLayoutConstraint.activate([
            vStackView.centerXAnchor.constraint(equalTo: testLabel.centerXAnchor),
            vStackView.topAnchor.constraint(equalTo: testLabel.bottomAnchor),
            vStackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            vStackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            vStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            vStackView.widthAnchor.constraint(equalToConstant: 100),
            vStackView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        hStackView.addArrangedSubview(button)
        hStackView.addArrangedSubview(button)
        
        NSLayoutConstraint.activate([
//            hStackView.centerXAnchor.constraint(equalTo: vStackView.centerXAnchor),
//            button.centerYAnchor.constraint(equalTo: testLabel.centerYAnchor),
            hStackView.topAnchor.constraint(equalTo: vStackView.bottomAnchor),
            hStackView.leftAnchor.constraint(equalTo: vStackView.leftAnchor),
            hStackView.rightAnchor.constraint(equalTo: vStackView.rightAnchor),
            hStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hStackView.widthAnchor.constraint(equalToConstant: 200),
            hStackView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        
    }
}
