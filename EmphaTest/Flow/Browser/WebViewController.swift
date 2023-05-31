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
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    let viewModel: WebViewModel
    
    init(viewModel: WebViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private func bindViewModel() {
        viewModel.updateView = { [weak self] in
            DispatchQueue.main.async {
                guard let request = self?.viewModel.urlRequest else {
                    let alert = UIHelper.createErrorAlert()
                    self?.activityIndicator.stopAnimating()
                    self?.present(alert, animated: true)
                    return
                }
                
                self?.activityIndicator.startAnimating()
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
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        present(UIHelper.createErrorAlert(), animated: true)
    }
}
