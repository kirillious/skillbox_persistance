//
//  ViewControllerC.swift
//  skillbox_persistance
//
//  Created by Kirill on 03.05.2021.
//

import UIKit

class ViewControllerC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(button)
        view.addSubview(textField)
        setConsts()
        tableView.dataSource = self
        tableView.delegate = self
        listOfData = Persistence.shared.fetchingCoreData()

    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell2.self, forCellReuseIdentifier: TableViewCell2.identifier)
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
    
    var listOfData: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }

}

extension ViewControllerC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell2.identifier, for: indexPath) as! TableViewCell2
        cell.label.text = listOfData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Persistence.shared.removeTaskCoreData(taskNumber: indexPath.row)
        listOfData.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
}

extension ViewControllerC: UITextFieldDelegate {
    
    @objc func updateListButton (sender: UIButton!) {
        if textField.text != "" {
            textField.placeholder = ""
            listOfData.append(textField.text!)
            Persistence.shared.addTaskCoreData(task1: textField.text!)
            textField.text = ""
        } else {
            textField.placeholder = "Type something"
        }
    }
}
