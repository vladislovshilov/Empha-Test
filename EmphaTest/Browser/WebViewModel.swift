//
//  WebViewModel.swift
//  EmphaTest
//
//  Created by macbook pro max on 31/05/2023.
//

import Foundation

final class WebViewModel {
    var webViewReloadCallback: ((_ urlRequest: URLRequest) -> Void)?
    
    private let browsingHistoryService = BrowsingHistoryService.shared
    
    func browseURL(constructedFrom string: String) {
        var urlString = string
        if !urlString.hasPrefix("http://") && !urlString.hasPrefix("https://") {
            urlString.insert(contentsOf: "https://", at: urlString.startIndex)
        }
        
        guard let url = URL(string: urlString) else {
            print("invalid url")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        webViewReloadCallback?(urlRequest)
        
        saveURL(url)
    }
    
    func openHistory() { }
    
    func saveURL(_ url: URL) {
        browsingHistoryService.saveURLToHistory(url)
    }
}
