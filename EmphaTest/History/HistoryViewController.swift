//
//  HistoryViewController.swift
//  EmphaTest
//
//  Created by macbook pro max on 31/05/2023.
//

import UIKit

class HistoryViewController: UIViewController {
    var selectedURL: URL?
    
    private var tableView: UITableView!
    
    private let browsingHistoryService = BrowsingHistoryService.shared
    private var history = [History]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        history = browsingHistoryService.loadHistory()
    }
}

// MARK: - UITableViewDataSource

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = history[indexPath.row].url?.description
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedURL = history[indexPath.row].url
        dismiss(animated: true)
    }
}
