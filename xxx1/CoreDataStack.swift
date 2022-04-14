//
//  CoreDataStack.swift
//  xxx1
//
//  Created by Yan Cheng Cheok on 11/04/2022.
//

import CoreData

class CoreDataStack {
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    static let INSTANCE = CoreDataStack()
    
    private init() {
    }
    
    private(set) lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentCloudKitContainer(name: "xxx1")
        //let container = NSPersistentContainer(name: "xxx1")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // This is a serious fatal error. We will just simply terminate the app, rather than using error_log.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        // So that when backgroundContext write to persistent store, container.viewContext will retrieve update from
        // persistent store.
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        // TODO: Not sure these are required...
        //
        //container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        //container.viewContext.undoManager = nil
        //container.viewContext.shouldDeleteInaccessibleFaults = true
        
        return container
    }()
    
    private(set) lazy var backgroundContext: NSManagedObjectContext = {
        let backgroundContext = persistentContainer.newBackgroundContext()

        // Similar behavior as Android's Room OnConflictStrategy.REPLACE
        // Old data will be overwritten by new data if index conflicts happen.
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        // TODO: Not sure these are required...
        //backgroundContext.undoManager = nil
        
        return backgroundContext
    }()
    
    static func saveContextIfPossible(_ context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
