//
//  CandyView.swift
//  VIPER_Study2
//
//  Created by Chung Wussup on 5/24/24.
//

import UIKit

protocol CandyViewProtocol: class {
    var presenter: CandyPresenterProtocol? { get set }
    func set(viewModel: CandyViewModel) // Set the view Object of Type CandyEntity
    func set(totalPriceViewModel viewModel: TotalPriceViewModel) // Set the view price object
}

class CandyView: UIViewController {
    private var candyImageView: UIImageView!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var priceLabel: UILabel!
    private var quantityStepper: UIStepper!
    private var quantityLabel: UILabel!
    
    private var totalPriceLabel: UILabel!
    private var taxLabel: UILabel!
    private var inclTaxLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension CandyView: CandyViewProtocol {
    
    func set(viewModel: CandyViewModel) {

        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        priceLabel.text = viewModel.price

        candyImageView.image = UIImage(named: viewModel.imageName)
    }
    
    func set(totalPriceViewModel viewModel: TotalPriceViewModel) {
        //excl tax, incl tax, VAT
        quantityLabel.text = viewModel.quantity
        totalPriceLabel.text = viewModel.totalPrice
        taxLabel.text = viewModel.vat
        inclTaxLabel.text = viewModel.totalInclTax
    }

}
