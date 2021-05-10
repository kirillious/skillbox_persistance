//
//  ViewController.swift
//  skillbox_persistance
//
//  Created by Kirill on 28.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textField1)
        view.addSubview(textField2)
        addConsts()
        textField1.text = Persistence.shared.userName
        textField2.text = Persistence.shared.userSurname
    }
    
    lazy var textField1: UITextField = {
        let textField1 = UITextField()
        textField1.borderStyle = UITextField.BorderStyle.line
        textField1.tag = 0
        textField1.delegate = self
        textField1.translatesAutoresizingMaskIntoConstraints = false
        return textField1
    }()
    
    lazy var textField2: UITextField = {
        let textField2 = UITextField()
        textField2.borderStyle = UITextField.BorderStyle.line
        textField2.tag = 1
        textField2.delegate = self
        textField2.translatesAutoresizingMaskIntoConstraints = false
        return textField2
    }()
    
    func addConsts () {
        NSLayoutConstraint.activate([textField2.centerXAnchor.constraint(equalTo: view.centerXAnchor), textField2.centerYAnchor.constraint(equalTo: view.centerYAnchor), textField2.widthAnchor.constraint(equalTo: view.widthAnchor), textField2.heightAnchor.constraint(equalToConstant: 30)])
        
        NSLayoutConstraint.activate([ textField1.heightAnchor.constraint(equalToConstant: 30), textField1.leftAnchor.constraint(equalTo: view.leftAnchor), textField1.rightAnchor.constraint(equalTo: view.rightAnchor), textField1.bottomAnchor.constraint(equalTo: textField2.topAnchor, constant: -20)])
        
    }
    
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 0 {
            Persistence.shared.userName = textField.text
        } else {
            Persistence.shared.userSurname = textField.text
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            let hitView = self.view.hitTest(firstTouch.location(in: self.view), with: event)
            
            if hitView === view {
                view.endEditing(true)
            }
        }
    }
}
