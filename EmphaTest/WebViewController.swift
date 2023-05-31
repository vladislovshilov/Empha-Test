//
//  ViewController.swift
//  EmphaTest
//
//  Created by macbook pro max on 31/05/2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var historyButton: UIButton!
    @IBOutlet private weak var webView: WKWebView!
    
    private let viewModel = WebViewModel(browsingHistoryService: .init(coreDataStack: .init(modelName: "EmphaTest")))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
        
        viewModel.webViewReloadCallback = { [weak self] request in
            self?.webView.load(request)
            self?.searchTextField.text = request.url?.description
        }
    }

    @IBAction private func historyButtonDidPress(_ sender: Any) {
        viewModel.openHistory()
    }
}

// MARK: - UITextFieldDelegate

extension WebViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.browseURL(constructedFrom: textField.text ?? "")
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        viewModel.browseURL(constructedFrom: textField.text ?? "")
        return true
    }
}

// MARK: - WKUIDelegate

extension WebViewController: WKUIDelegate {
    
}
