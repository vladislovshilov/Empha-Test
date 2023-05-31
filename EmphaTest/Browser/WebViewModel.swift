//
//  WebViewModel.swift
//  EmphaTest
//
//  Created by macbook pro max on 31/05/2023.
//

import Foundation

final class WebViewModel {
    var updateView: (() -> Void)?
    
    var urlRequest: URLRequest?
    
    private let browsingHistoryService = BrowsingHistoryService.shared
    private let coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func browseURL(constructedFrom string: String) {
        var urlString = string
        if !urlString.hasPrefix("http://") && !urlString.hasPrefix("https://") {
            urlString.insert(contentsOf: "https://", at: urlString.startIndex)
        }
        
        browseURL(URL(string: urlString))
    }
    
    func browseURL(_ url: URL?) {
        guard let url = url else {
            print("invalid url")
            return
        }
        
        urlRequest = URLRequest(url: url)
        
        saveURL(url)
        updateView?()
    }
    
    func saveURL(_ url: URL) {
        browsingHistoryService.saveURLToHistory(url)
    }
    
    func openHistory() {
        coordinator.openHistory()
    }
}
