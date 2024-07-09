//
//  SearchTableViewCell.swift
//  CombineTest
//
//  Created by Chung Wussup on 5/6/24.
//

import UIKit
import SnapKit

class SearchTableViewCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var publisherLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    
    private lazy var thumbnailIV: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var noImageLabel: UILabel = {
        let label = UILabel()
        label.text = "No Image🥲"
        label.font = .systemFont(ofSize: 12)
        label.isHidden = true
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        thumbnailIV.image = nil
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupUI() {
        
        [titleLabel, authorLabel, publisherLabel, priceLabel, thumbnailIV, dateLabel].forEach {
            contentView.addSubview($0)
        }
        
        thumbnailIV.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(15)
            $0.leading.equalTo(contentView).offset(15)
            
            $0.width.height.equalTo(100)
            $0.bottom.equalTo(contentView).inset(15)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbnailIV.snp.trailing).offset(15)
            $0.trailing.equalTo(contentView.snp.trailing).inset(15)
            $0.top.equalTo(thumbnailIV.snp.top).offset(10)
        }
        
        authorLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbnailIV.snp.trailing).offset(15)
            $0.trailing.equalTo(contentView.snp.trailing).inset(15)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        publisherLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbnailIV.snp.trailing).offset(15)
            $0.trailing.equalTo(contentView.snp.trailing).inset(15)
            $0.top.equalTo(authorLabel.snp.bottom).offset(5)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbnailIV.snp.trailing).offset(15)
            $0.trailing.equalTo(contentView.snp.trailing).inset(15)
            $0.top.equalTo(publisherLabel.snp.bottom).offset(5)
            $0.bottom.equalTo(contentView.snp.bottom).inset(21)
        }
        
        self.thumbnailIV.addSubview(noImageLabel)
        noImageLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    func bindCell(book: Book) {
        titleLabel.text = book.title
        authorLabel.text = book.authors.first
        publisherLabel.text = book.publisher
        dateLabel.text = book.dateString

        
        if let imageUrl = URL(string: book.thumbnail) {
            downloadImage(from: imageUrl)
            self.noImageLabel.isHidden = true
        } else {
            self.thumbnailIV.image = nil
            self.noImageLabel.isHidden = false
        }
    }
    
    private func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Error downloading image: \(error)")
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.thumbnailIV.image = image
                }
            }
        }
        .resume()
    }
    
    
}

