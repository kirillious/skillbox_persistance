//
//  ViewControllerD.swift
//  skillbox_persistance
//
//  Created by Kirill on 04.05.2021.
//

import UIKit

struct Weather: Decodable {
    let list: [Info]
}

struct Info: Decodable {
    let main: DailyData
}

struct DailyData: Decodable {
    let temp: Double
}

class ViewControllerD: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(button)
        view.addSubview(textField)
        setConsts()
        tableView.dataSource = self
        tableView.delegate = self
        degrees = Persistence.shared.retriveWeatherList()
        Persistence.shared.createObjects()
        getJson()
    }
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCellD.self, forCellReuseIdentifier: TableViewCellD.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = UITextField.BorderStyle.line
        textField.tag = 0
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
    
    func getJson() {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=Moscow&appid=2673e55b83290f3528bef199eb2aa00f&units=metric")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data,response,error) in
            
            guard let data = data else {return}
            
            let weatherData = try? JSONDecoder().decode(Weather.self, from: data)
            var listOfDegrees: [String] = []
            
            var i = 0
            while i < 16 {
                
                listOfDegrees.append(String((weatherData?.list[i].main.temp)!))

                i += 1
            }
            DispatchQueue.main.async {
                self.degrees = listOfDegrees
                self.tableView.reloadData()
//                print(self.degrees)
                Persistence.shared.updateMemory(list: self.degrees)

            }
        }
        task.resume()
        
    }
    
    
    @objc func updateListButton (sender: UIButton!) {
        
    }
    
    
    var degrees: [String] = []
    
    
    
}

extension ViewControllerD: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return degrees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellD.identifier, for: indexPath) as! TableViewCellD
        cell.label.text = degrees[indexPath.row]
        return cell
    }
    
    
}
