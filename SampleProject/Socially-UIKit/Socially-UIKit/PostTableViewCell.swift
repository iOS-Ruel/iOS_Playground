//
//  PostTableViewCell.swift
//  Socially-UIKit
//
//  Created by Chung Wussup on 7/25/24.
//

import UIKit
import Kingfisher
class PostTableViewCell: UITableViewCell {
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: 0, y: 0, width: 320, height: 200)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(postImageView)
        
        NSLayoutConstraint.activate([
            postImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            postImageView.widthAnchor.constraint(equalToConstant: 320),
            
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func configureCell(with post: Post) {
        self.descriptionLabel.text = post.description
        
        let processor = DownsamplingImageProcessor(size: postImageView.bounds.size)
        postImageView.kf.indicatorType = .activity
        
//        if let imageUrl = post.imageURL  {
//            self.postImageView.kf.setImage(with: URL(string: imageUrl),
//                                           placeholder: UIImage(systemName: "photo.artframe"),
//                                           options: [.processor(processor), .scaleFactor(UIScreen.main.scale),
//                                                     .transition(.fade(0.2)),
//                                                     .cacheOriginalImage])
//            
//        } else {
//            postImageView.image = UIImage(systemName: "photo.artframe")
//        }
        if let imageURL = post.imageURL {
                   postImageView.kf.setImage(
                       with: URL(string: imageURL)!,
                       placeholder: UIImage(systemName: "photo.artframe"),
                       options: [
                           .processor(processor),
                           .scaleFactor(UIScreen.main.scale),
                           .transition(.fade(0.2)),
                           .cacheOriginalImage
                       ]
                   )
               } else {
                   postImageView.image = UIImage(systemName: "photo.artframe")
               }
        
        
    }
    
}
