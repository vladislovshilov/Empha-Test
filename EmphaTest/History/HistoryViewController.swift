//
//  HistoryViewController.swift
//  EmphaTest
//
//  Created by macbook pro max on 31/05/2023.
//

import UIKit

protocol HistoryViewControllerDelegate {
    func loadSavedURL(_ url: URL?)
}

class HistoryViewController: UITableViewController {
    
    var delegate: HistoryViewControllerDelegate?

    private let browsingHistoryService = BrowsingHistoryService.shared
    private var history = [History]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        history = browsingHistoryService.loadHistory()
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = history[indexPath.row].url?.description

        return cell
    }
        
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.loadSavedURL(history[indexPath.row].url)
        dismiss(animated: true)
    }
}
