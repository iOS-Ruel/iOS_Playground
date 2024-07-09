//
//  PokeListTVCell.swift
//  VIPER_Study3
//
//  Created by Chung Wussup on 6/9/24.
//

import UIKit

class PokeListTVCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private let urlLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(urlLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(equalToConstant: 15),
            
            urlLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            urlLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            urlLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            urlLabel.heightAnchor.constraint(equalToConstant: 15),
            urlLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
            
        ])
    }
    
    
    func configureUI(pokemon: PokeResults) {
        nameLabel.text = pokemon.name
        urlLabel.text = pokemon.url
    }
    
}
