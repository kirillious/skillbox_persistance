//
//  TableViewCell2.swift
//  skillbox_persistance
//
//  Created by Kirill on 03.05.2021.
//

import UIKit

class TableViewCell2: UITableViewCell {
    
    static let identifier = "TableViewCell2"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        addingConsts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func addingConsts() {
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: contentView.topAnchor), label.leftAnchor.constraint(equalTo: contentView.leftAnchor), label.rightAnchor.constraint(equalTo: contentView.rightAnchor)])
    }



}
