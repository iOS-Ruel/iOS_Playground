//
//  PlaceListViewController.swift
//  CamPlace
//
//  Created by Chung Wussup on 6/15/24.
//

import UIKit

class PlaceListViewController: UIViewController {
    @Published var locationList: [LocationBasedListModel]

    private lazy var listTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 100
        tv.register(PlaceListTableViewCell.self, forCellReuseIdentifier: "PlaceListTableViewCell")
        return tv
    }()
    
    init(locationList: [LocationBasedListModel]) {
        self.locationList = locationList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .blue
        title = "목록"
    }
    
    private func setupUI() {
        view.addSubview(listTableView)
        
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: view.topAnchor),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    
}

extension PlaceListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceListTableViewCell", for: indexPath) as? PlaceListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setupCell(content: locationList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let content = locationList[indexPath.row]
        let viewModel = PlaceDetailViewModel(content: content)
        let vc = PlaceDetailViewController(viewModel: viewModel)
        let naviController = UINavigationController(rootViewController: vc)
        naviController.modalPresentationStyle = .fullScreen
        self.present(naviController, animated: false)
    }
    
    
}
