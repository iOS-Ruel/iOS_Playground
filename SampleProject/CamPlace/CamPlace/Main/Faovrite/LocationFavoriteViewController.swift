//
//  LocationFavoriteViewController.swift
//  CamPlace
//
//  Created by Chung Wussup on 7/5/24.
//

import UIKit
import Combine

class LocationFavoriteViewController: UIViewController {
    private let viewModel = LocationFavoriteViewModel()
    private var cancellables: Set<AnyCancellable> = []

    private lazy var listTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 100
        tv.backgroundColor = .white
        tv.register(PlaceListTableViewCell.self, forCellReuseIdentifier: "PlaceListTableViewCell")
        return tv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavi()
        bindData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(listTableView)
        
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: view.topAnchor),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavi() {
        self.navigationController?.navigationBar.topItem?.title = "즐겨찾기"
    }
    
    private func bindData() {
        viewModel.$locations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.listTableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension LocationFavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceListTableViewCell",
                                                       for: indexPath) as? PlaceListTableViewCell else {
            return UITableViewCell()
        }
        
        let content: LocationBasedListModel = LocationBasedListModel(from: viewModel.locations[indexPath.row])
        cell.setupCell(content: content)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let content: LocationBasedListModel = LocationBasedListModel(from: viewModel.locations[indexPath.row])
        let viewModel = PlaceDetailViewModel(content: content)
        let vc = PlaceDetailViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
