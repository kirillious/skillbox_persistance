//
//  TableViewCell.swift
//  skillbox_persistance
//
//  Created by Kirill on 01.05.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addSubview(label)
        setConst()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setConst() {
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: contentView.topAnchor), label.rightAnchor.constraint(equalTo: contentView.rightAnchor)])
    }

}
