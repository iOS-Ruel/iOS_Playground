//
//  NewPostViewController.swift
//  Socially-UIKit
//
//  Created by Chung Wussup on 7/25/24.
//

import UIKit

class NewPostViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .secondarySystemGroupedBackground
        return iv
    }()

    
    private let selectImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
            
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "New Post"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
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
