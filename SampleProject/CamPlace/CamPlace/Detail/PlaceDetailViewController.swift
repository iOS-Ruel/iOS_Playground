//
//  PlaceDetailViewController.swift
//  CamPlace
//
//  Created by Chung Wussup on 6/19/24.
//

import UIKit
import Combine

enum DetailCellType {
    case image(imageUrls: [String])
    case info(content: LocationBasedListModel)
    case map(mapX: String, mapY: String, titleWithAdress: String)
}

class PlaceDetailViewController: UIViewController {
    private let viewModel: PlaceDetailViewModel
    private var cancellables = Set<AnyCancellable>()
    
    
    private var cellType: [DetailCellType] = []
    
    
    private lazy var detailTV: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.register(DetailImageTableViewCell.self, forCellReuseIdentifier: "DetailImageTableViewCell")
        tv.register(DetailMapTableViewCell.self, forCellReuseIdentifier: "DetailMapTableViewCell")
        tv.register(DetailInfoTableViewCell.self, forCellReuseIdentifier: "DetailInfoTableViewCell")
        return tv
    }()
    
    
    init(viewModel: PlaceDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        title = viewModel.getContentTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        setupUI()
        bindViewModel()
    }
    
    private func setupNavi() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(dismissView))
    }
    
    private func setupUI(){
        view.addSubview(detailTV)
        NSLayoutConstraint.activate([
            detailTV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailTV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailTV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailTV.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.$imageList
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateCellType()
                self?.detailTV.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func updateCellType() {
        cellType = []
        cellType.append(.image(imageUrls: viewModel.getImages()))
        cellType.append(.info(content: viewModel.getContent()))
        cellType.append(.map(mapX: viewModel.getMapX(),
                             mapY: viewModel.getMapY(),
                             titleWithAdress: viewModel.getTitle()))
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: false)
    }
    
}


extension PlaceDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellType[indexPath.row] {
        case .image(imageUrls: let images):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailImageTableViewCell", for: indexPath) as? DetailImageTableViewCell {
                cell.setupCell(imageUrls: images)
                return cell
            }
        case .map(mapX: let mapX, mapY: let mapY, titleWithAdress: let title):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailMapTableViewCell", for: indexPath) as? DetailMapTableViewCell {
                cell.setupCell(mapX: mapX, mapY: mapY, title: title)
                    return cell
            }
        case .info(content: let content):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailInfoTableViewCell", for: indexPath) as? DetailInfoTableViewCell {
                cell.setupCell(content: content)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}

/*
 image
 
 info:
 "facltNm": 이름
 "intro": 설명
 "doNm": 도(ex: 경상북도)
 "sigunguNm": 시군구(Ex:군위군)
 
 "addr1": 주소
 "addr2": 주소 상세
 
 "featureNm": 특징
 "homepage": 홈페이지
 "sbrsCl": 부대시설
 "sbrsEtc": 부대시설 기타
 "tel": 전화
 "animalCmgCl": 애완동물 출입여부
 
 map:
 "mapX": 경위
 "mapY": 위도
 "direction": 오시는길
 
 */
