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
        if let url = url,
           isValidURL(url) {
            urlRequest = URLRequest(url: url)
            
            if shouldSave {
                browsingHistoryService.saveURLToHistory(url)
            }
        } else {
            urlRequest = nil
        }
        
        updateView?()
    }
    
    func saveURL(_ url: URL) {
        browsingHistoryService.saveURLToHistory(url)
    }
    
    func openHistory() {
        coordinator.openHistory()
    }
    
    func isValidURL(_ url: URL) -> Bool {
        let urlRegex = "^https?://(?:www\\.)?([\\w-]+\\.)+[\\w-]+[\\w./?=&#%+\\-]*$"
        let urlPredicate = NSPredicate(format: "SELF MATCHES %@", urlRegex)
        return urlPredicate.evaluate(with: url.absoluteString)
    }
}
