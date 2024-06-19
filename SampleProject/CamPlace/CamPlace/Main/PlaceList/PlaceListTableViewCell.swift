//
//  PlaceListTableViewCell.swift
//  CamPlace
//
//  Created by Chung Wussup on 6/19/24.
//

import UIKit

class PlaceListTableViewCell: UITableViewCell {
    
    private var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var mainStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 5
        return sv
    }()
    
    private var contentStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 5
        
        sv.distribution = .fillEqually
        return sv
    }()
    
    private var placeImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupCell(content: LocationBasedListModel) {
        titleLabel.text = content.title
        
        infoLabel.isHidden = content.lineIntro == "" ? true : false
        infoLabel.text = content.lineIntro
        
        addressLabel.text = content.subTitle
        
        if let imageUrl = content.imageUrl {
            ImageLoader.loadImageFromUrl(imageUrl, completion: {[weak self] image in
                DispatchQueue.main.async {
                    self?.placeImageView.image =  image
                }
            })
        }
    }
    
    
    private func setupUI() {
        contentView.addSubview(mainView)
        mainView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(placeImageView)
        mainStackView.addArrangedSubview(contentStackView)
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(infoLabel)
        contentStackView.addArrangedSubview(addressLabel)
        
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: mainView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            
            
            placeImageView.heightAnchor.constraint(equalToConstant: 100),
            placeImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        
    }
    
}
