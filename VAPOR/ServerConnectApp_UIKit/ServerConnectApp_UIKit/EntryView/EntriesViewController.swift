//
//  EntriesViewController.swift
//  ServerConnectApp_UIKit
//
//  Created by Chung Wussup on 7/18/24.
//

import UIKit

class EntriesViewController: UIViewController {
    
    private lazy var entriesTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(EntryTableViewCell.self, forCellReuseIdentifier: "EntryCell")
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .clear
        return tv
    }()
    
    let entries: [Entry] = [
        Entry(id: UUID(),title: "Swift", content: "iOS programingLanguage"),
        Entry(id: UUID(),title: "Swift", content: "iOS programingLanguage"),
        Entry(id: UUID(),title: "UIKit", content: "i use UIKit for iOS Develop"),
        Entry(id: UUID(),title: "SwiftUI", content: "SwiftUI is So difficult"),
        Entry(id: UUID(),title: "what", content: "create stunning social graphics in seconds")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    private func configureUI() {
        title = "Entries"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(entryAddButtonTouch))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(logoutButtonTouch))
//        (image: UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(entryAddButtonTouch))
//        navigationItem.rightBarButtonItem?.tintColor = .white
        
        view.backgroundColor = UIColor(named: "mainColor")
        
        view.addSubview(entriesTableView)
        
        NSLayoutConstraint.activate([
            entriesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            entriesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            entriesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            entriesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    @objc func entryAddButtonTouch() {
        let addView = UINavigationController(rootViewController: EntryAddViewController())
        addView.modalPresentationStyle = .fullScreen
        self.present(addView, animated: true)
    }
    
    
    @objc func logoutButtonTouch() {
        let loginVC = LoginViewController()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate {
            DispatchQueue.main.async {
                sceneDelegate.switchToEntriesViewController(vc: loginVC)
            }
        }
    }
}

extension EntriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell",
                                                       for: indexPath) as? EntryTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(entry: entries[indexPath.row])
        return cell
    }
    
    
}

#Preview() {
    UINavigationController(rootViewController: EntriesViewController())
    
}
