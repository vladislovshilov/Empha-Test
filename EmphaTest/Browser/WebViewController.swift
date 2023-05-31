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
    @IBOutlet private weak var webView: WKWebView!
    
    let viewModel: WebViewModel
    
    init(viewModel: WebViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        bindViewModel()
    }
    
    @IBAction func historyButtonDidPress(_ sender: Any) {
        viewModel.openHistory()
    }
    
    override func canPerformUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, sender: Any?) -> Bool {
        if let controller = fromViewController as? HistoryViewController {
            viewModel.browseURL(controller.selectedURL)
        }
        return true
    }
    
    private func bindViewModel() {
        viewModel.updateView = { [weak self] in
            DispatchQueue.main.async {
                guard let request = self?.viewModel.urlRequest else {
                    let alert = UIAlertController(title: "Ooops", message: "Something went wrong. Try again", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(okAction)
                    self?.present(alert, animated: true)
                    return
                }
                
                self?.webView.load(request)
                self?.searchTextField.text = request.url?.description
            }
        }
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

// MARK: - WKWebView

extension WebViewController: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url,
           url.scheme != "about" {
            viewModel.saveURL(url)
        }
        
        decisionHandler(.allow)
    }
}
