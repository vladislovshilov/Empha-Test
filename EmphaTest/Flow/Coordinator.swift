//
//  Coordinator.swift
//  EmphaTest
//
//  Created by macbook pro max on 31/05/2023.
//

import UIKit

class Coordinator {
    private let navigationController: UINavigationController
    private let browsingHistoryService: BrowsingHistoryService
    private var webViewController: WebViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.browsingHistoryService = BrowsingHistoryService(coreDataStack: .init())
    }

    func start() {
        let webViewModel = WebViewModel(coordinator: self, browsingHistoryService: browsingHistoryService)
        webViewController = WebViewController(viewModel: webViewModel)

        navigationController.pushViewController(webViewController!, animated: true)
    }

    func openHistory() {
        let historyViewController = HistoryViewController(browsingHistoryService: browsingHistoryService)
        historyViewController.urlCallback = { [weak self] url in
            self?.webViewController?.viewModel.browseURL(url, shouldSave: false)
        }
        
        navigationController.present(historyViewController, animated: true)
    }
}
