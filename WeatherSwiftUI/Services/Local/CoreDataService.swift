//
//  CoreDataService.swift
//  WeatherSwiftUI
//
//  Created by Светлана Шибаева on 27.11.2023.
//

import Foundation
import CoreData

final class CoreDataService {
    static let shared = CoreDataService()
    
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherSwiftUI")
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
