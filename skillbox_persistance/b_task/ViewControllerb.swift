//
//  ViewControllerb.swift
//  skillbox_persistance
//
//  Created by Kirill on 01.05.2021.
//

import UIKit

class ViewControllerb: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(button)
        view.addSubview(textField)
        setConsts()
        tableView.dataSource = self
        tableView.delegate = self
        listOfTasks = Persistence.shared.updateListDidLoad()
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = UITextField.BorderStyle.line
        textField.tag = 0
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector (updateListButton), for: .touchUpInside)
        button.setTitle("Add", for: .normal)
        button.backgroundColor = .link
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    func setConsts() {
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.topAnchor), tableView.leftAnchor.constraint(equalTo: view.leftAnchor) , tableView.rightAnchor.constraint(equalTo: view.rightAnchor), tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)])
        
        NSLayoutConstraint.activate([button.topAnchor.constraint(equalTo: tableView.bottomAnchor), button.rightAnchor.constraint(equalTo: view.rightAnchor), button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor), button.widthAnchor.constraint(equalToConstant: 50)])
        
        NSLayoutConstraint.activate([textField.topAnchor.constraint(equalTo: tableView.bottomAnchor), textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor), textField.leftAnchor.constraint(equalTo: view.leftAnchor), textField.rightAnchor.constraint(equalTo: button.leftAnchor)])
    }
    
    var listOfTasks:[String] = [] {
        didSet {
            tableView.reloadData()
        }
    }



}

extension ViewControllerb: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.label.text = listOfTasks[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Persistence.shared.deleteTask(taskNumber: indexPath.row)
        listOfTasks.remove(at: indexPath.row)
        tableView.reloadData()
    }
    

}


extension ViewControllerb: UITextFieldDelegate {
    
    @objc func updateListButton(sender: UIButton!) {
        if textField.text != "" {
            textField.placeholder = ""
            listOfTasks.append(textField.text!)
            Persistence.shared.addTask(task1: textField.text!)
            textField.text = ""
        } else {
            textField.placeholder = "Type something"
        }
    }

    
}
