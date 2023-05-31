//
//  CoreDataStack.swift
//  EmphaTest
//
//  Created by macbook pro max on 31/05/2023.
//

import CoreData

enum CoreDataError: Error {
    case customError(String)
}

class CoreDataStack {
    private var persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext
    
    init() {
        let container = NSPersistentContainer(name: "EmphaTest")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Failed to load persistent stores: \(error), \(error.userInfo)")
            }
        }
        persistentContainer = container
        viewContext = persistentContainer.viewContext
    }
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Failed to save context: \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func fetchEnity() -> [History] {
//        guard let fetchRequest = T.fetchRequest() as? NSFetchRequest<T> else { return [] }
//
//        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//
//        guard let fetchedEntities = try? viewContext.fetch(fetchRequest) else { return [] }
//
//        return fetchedEntities
        
        let fetchRequest: NSFetchRequest<History> = History.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
            let fetchedEntities = try viewContext.fetch(fetchRequest)
            return fetchedEntities
        } catch {
            print("Error fetching entities: \(error)")
            return []
        }
    }
}
