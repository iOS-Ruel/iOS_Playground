//
//  ViewController.swift
//  Socially-UIKit
//
//  Created by Chung Wussup on 7/25/24.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {
    enum Section{
        case main
    }
    
    private var db: Firestore!
    private var dataSource: UITableViewDiffableDataSource<Section, Post>!
    private var tableView: UITableView!
    private var listener: ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feed"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "text.bubble"), tag: 0)
        
        db = Firestore.firestore()
        configureTableView()
        configureDataSource()
        startListeningToFirestore()
    }
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "postCell")
        tableView.rowHeight = 280
    }
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Post>(tableView: tableView) { (tableView, indexPath, item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "postCell")
            var config = cell?.defaultContentConfiguration()
            config?.text = item.description
            
            cell?.contentConfiguration = config
            
            return cell
        }
    }
    
    func startListeningToFirestore() {
        listener = db.collection("Posts").addSnapshotListener{ [weak self] querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            let posts = documents.compactMap { Post(document: $0) }
            self?.updateDataSource(with: posts)
            
        }
    }
    
    func updateDataSource(with posts: [Post]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Post>()
        snapShot.appendSections([.main])
        snapShot.appendItems(posts, toSection: .main)
        dataSource.apply(snapShot)
    }
    
    deinit {
        listener?.remove()
    }
    
}

