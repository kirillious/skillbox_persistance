//
//  TableViewCellD.swift
//  skillbox_persistance
//
//  Created by Kirill on 04.05.2021.
//

import UIKit

class TableViewCellD: UITableViewCell {
    
    static let identifier = "TableViewCellD"
    
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
        NSLayoutConstraint.activate([label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor), label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)])
    }



}
