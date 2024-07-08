//
//  PlaceListTableViewCell.swift
//  CamPlace
//
//  Created by Chung Wussup on 6/19/24.
//

import UIKit
import Combine

class PlaceListTableViewCell: UITableViewCell {
    deinit {
        print("PlaceListTableViewCell Deinit")
    }
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
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.addTarget(self, action: #selector(didFavoriteButton), for: .touchUpInside)
        return button
    }()
    
    var location: LocationBasedListModel?
    private var cancellables: Set<AnyCancellable> = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    
    func setupCell(content: LocationBasedListModel) {
        self.location = content
        titleLabel.text = content.title
        
        infoLabel.isHidden = content.lineIntro == "" ? true : false
        infoLabel.text = content.lineIntro
        
        addressLabel.text = content.subTitle
        
        
        if let imageUrl = content.imageUrl, imageUrl != ""{
            placeImageView.loadImage(from: imageUrl)
        } else {
            placeImageView.image = UIImage(systemName: "questionmark")
        }
        favoriteButtonSetup(content: content)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        titleLabel.text = nil
        infoLabel.text = nil
        addressLabel.text = nil
        placeImageView.image = UIImage(systemName: "questionmark")
    }
    
    
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(mainView)
        mainView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(placeImageView)
        mainStackView.addArrangedSubview(contentStackView)
        mainStackView.addArrangedSubview(favoriteButton)
        
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
            placeImageView.widthAnchor.constraint(equalToConstant: 100),
            
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func didFavoriteButton() {
        guard let locationContent = self.location else { return }
        
        CoreDataManager.shared.hasData(content: locationContent)
            .sink(receiveCompletion: { _ in }, 
                  receiveValue: { [weak self] hasData in
                guard let self = self else { return }
                
                if hasData {
                    CoreDataManager.shared.deleteData(content: locationContent)
                } else {
                    CoreDataManager.shared.createData(content: locationContent)
                }
                
                self.favoriteButtonSetup(content: locationContent)
            })
            .store(in: &cancellables)
    }
    
    private func favoriteButtonSetup(content: LocationBasedListModel) {
        CoreDataManager.shared.hasData(content: content)
            .sink(receiveCompletion: { _ in }, 
                  receiveValue: { [weak self] hasData in
                guard let self = self else { return }
                
                let favoriteImage = hasData ? UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal) : UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
                
                DispatchQueue.main.async {
                    self.favoriteButton.setImage(favoriteImage, for: .normal)
                }
            })
            .store(in: &cancellables)
    }
    
}
