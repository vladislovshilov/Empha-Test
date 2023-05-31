//
//  BrowseHistoryService.swift
//  EmphaTest
//
//  Created by macbook pro max on 31/05/2023.
//

import Foundation

final class BrowsingHistoryService {
    static let shared = BrowsingHistoryService(coreDataStack: .init())
    
    private let coreDataStack: CoreDataStack
    
    private init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func saveURLToHistory(_ url: URL) {
        let history = History(context: coreDataStack.viewContext)
        history.url = url
        history.date = Date()
        
        coreDataStack.saveContext()
    }
    
    func loadHistory() -> [History] {
        let histories: [History] = coreDataStack.fetchEnity()
        return histories
    }
}