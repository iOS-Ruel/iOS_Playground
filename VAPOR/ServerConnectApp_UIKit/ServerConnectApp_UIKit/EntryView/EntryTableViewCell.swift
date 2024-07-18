//
//  EntryTableViewCell.swift
//  ServerConnectApp_UIKit
//
//  Created by Chung Wussup on 7/18/24.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    private let stackView: UIStackView = {
       let sv = UIStackView()
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(named: "subTextColor")
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        selectionStyle = .none
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
        selectionStyle = .none
        configureUI()
    }
    
    private func configureUI() {
        contentView.addSubview(stackView)
        [titleLabel, descriptionLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13.5),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13.5)
        ])
    }
    
    func configureCell(entry: Entry) {
        titleLabel.text = entry.title
        descriptionLabel.text = entry.content
    }
    
}
