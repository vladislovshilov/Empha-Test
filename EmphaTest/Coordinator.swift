//
//  Coordinator.swift
//  EmphaTest
//
//  Created by macbook pro max on 31/05/2023.
//

import UIKit

class Coordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = WebViewModel(coordinator: self)
        let viewController = WebViewController(viewModel: viewModel)

        navigationController.pushViewController(viewController, animated: true)
    }

    func openHistory() {
        let historyViewController = HistoryViewController()
        navigationController.present(historyViewController, animated: true)
    }
}
