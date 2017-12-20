//
//  DBManager.swift
//  WorkOutForMuscles
//
//  Created by golanLeptop on 23/10/2017.
//  Copyright © 2017 golanLeptop. All rights reserved.
//

import UIKit
import CoreData

class DBManager: NSObject {
    
    static let manager = DBManager()
    
    
    func fetchExersices() ->[EntityExcersice]{
        
        let request: NSFetchRequest<EntityExcersice> = EntityExcersice.fetchRequest()
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        let dateSort = NSSortDescriptor(key: "date", ascending: false)
        
        request.sortDescriptors = [nameSort,dateSort]
        let controller = NSFetchedResultsController<EntityExcersice>(fetchRequest: request, managedObjectContext: persistentContainer.viewContext , sectionNameKeyPath: "name", cacheName: nil)
        try? controller.performFetch()
        
        let arr = controller.sections?.flatMap{
            $0.objects?.first as? EntityExcersice
        }

        return arr ?? []
    }

    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "WorkOutForMuscles")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
}
