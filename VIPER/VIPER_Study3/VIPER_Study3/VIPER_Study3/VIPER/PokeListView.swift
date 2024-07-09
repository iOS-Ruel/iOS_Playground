//
//  PokeListView.swift
//  VIPER_Study3
//
//  Created by Chung Wussup on 6/9/24.
//

import UIKit


protocol PokeListViewInterface: AnyObject {
    func showPokeData(poke: Pokemon)
}

class PokeListView: UIViewController, PokeListViewInterface {
    var presenter: PokeListModuleInterface!
    
    var poke: [PokeResults] = [] 
//    {
//        didSet {
//            listTableView.reloadData()
//        }
//    }
    
    private lazy var listTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(PokeListTVCell.self, forCellReuseIdentifier: "PokeListTVCell")
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        view.backgroundColor = .white
        setupUI()
        presenter.updateView()
    }
    
    private func setupUI() {
        view.addSubview(listTableView)
        
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func showPokeData(poke: Pokemon) {
        self.poke = poke.results
        self.listTableView.reloadData()
    }
    
    
    
}

extension PokeListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.poke.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PokeListTVCell") as? PokeListTVCell {
            cell.configureUI(pokemon: self.poke[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    
}
