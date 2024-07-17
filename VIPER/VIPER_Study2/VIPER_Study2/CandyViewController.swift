//
//  CandyViewController.swift
//  VIPER_Study2
//
//  Created by Chung Wussup on 7/16/24.
//

import UIKit


protocol CandyViewInterface: AnyObject {
    func configureCandyData(candy: CandyEntity)
}

class CandyViewController: UIViewController, CandyViewInterface {
    
    var presenter: CandyViewModuleInterface!
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    private let priceStackView: UIStackView = {
       let sv = UIStackView()
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countStepper: UIStepper = {
       let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    
    private let resultView: UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalTaxPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureUI()
        presenter.updateView()
    }
    
    
    func configureUI() {
        view.addSubview(imageView)
        
        view.addSubview(titleLabel)
        view.addSubview(infoLabel)
        
        view.addSubview(priceStackView)
        [priceLabel, countLabel, countStepper].forEach {
            priceStackView.addArrangedSubview($0)
        }
        
        view.addSubview(resultView)
        [totalPriceLabel, totalTaxPriceLabel].forEach {
            resultView.addSubview($0)
        }
        
        
        titleLabel.text = "Candy Title"
        infoLabel.text = "Magic Candies coming from heaven, if you eat one and say a wish. Your wish will be granted"
        priceLabel.text = "1,000 ₩"
        countLabel.text = "Quantity: 0"
        totalPriceLabel.text = "Price : 5,000 ₩"
        totalTaxPriceLabel.text = "Tva : 200 Excl: 6,700 ₩"
        
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.imageView.heightAnchor.constraint(equalToConstant: 200),
            self.imageView.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            priceStackView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20),
            priceStackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
            priceStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            resultView.topAnchor.constraint(greaterThanOrEqualTo: priceStackView.bottomAnchor, constant: 16),
            resultView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            resultView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            
            
            totalPriceLabel.topAnchor.constraint(equalTo: resultView.topAnchor, constant: 5),
            totalPriceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: resultView.leadingAnchor, constant: 16),
            totalPriceLabel.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -5),
            totalTaxPriceLabel.topAnchor.constraint(equalTo: totalPriceLabel.bottomAnchor, constant: 5),
            totalTaxPriceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: resultView.leadingAnchor, constant: 16),
            totalTaxPriceLabel.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -5),
            totalTaxPriceLabel.bottomAnchor.constraint(equalTo: resultView.bottomAnchor, constant: -5)
            
        ])
                
    }
    
    
    func configureCandyData(candy: CandyEntity) {
        self.titleLabel.text = candy.title
        self.infoLabel.text = candy.description
        self.priceLabel.text = "\(candy.price) ₩"
        self.imageView.imageLoad(url: candy.imageName)
    }
    
    
}

#Preview() {
    CandyViewController()
}
