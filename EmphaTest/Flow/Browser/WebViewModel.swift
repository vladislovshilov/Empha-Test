//
//  WebViewModel.swift
//  EmphaTest
//
//  Created by macbook pro max on 31/05/2023.
//

import Foundation

final class WebViewModel {
    var urlRequest: URLRequest?
    var updateView: (() -> Void)?
    
    private let coordinator: Coordinator
    private let browsingHistoryService: BrowsingHistoryService
    
    init(coordinator: Coordinator, browsingHistoryService: BrowsingHistoryService) {
        self.coordinator = coordinator
        self.browsingHistoryService = browsingHistoryService
    }
    
    func browseURL(constructedFrom string: String) {
        var urlString = string
        if !urlString.hasPrefix("http://") && !urlString.hasPrefix("https://") {
            urlString.insert(contentsOf: "https://", at: urlString.startIndex)
        }
        
        browseURL(URL(string: urlString))
    }
    
    func browseURL(_ url: URL?, shouldSave: Bool = true) {
        guard let url = url else {
            print("invalid url")
            return
        }
        
        urlRequest = URLRequest(url: url)
        
        browsingHistoryService.saveURLToHistory(url)
        updateView?()
    }
    
    func saveURL(_ url: URL) {
        browsingHistoryService.saveURLToHistory(url)
    }
    
    func openHistory() {
        coordinator.openHistory()
    }
}
