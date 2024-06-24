//
//  PlaceListViewController.swift
//  CamPlace
//
//  Created by Chung Wussup on 6/15/24.
//

import UIKit
import Combine

class PlaceListViewController: UIViewController {
    @Published var locationList: [LocationBasedListModel]
    private var cancellables = Set<AnyCancellable>()
    
    
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
    
    init(locationList: [LocationBasedListModel]) {
        self.locationList = locationList
        super.init(nibName: nil, bundle: nil)
        bindTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavi()
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
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        title = "목록"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(dismissView))
    }
    
    
    //TODO: - 굳이 combine을 써야할까?
    private func bindTableView() {
        $locationList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.listTableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: true)
    }
    
    
}

extension PlaceListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceListTableViewCell", 
                                                       for: indexPath) as? PlaceListTableViewCell else {
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
