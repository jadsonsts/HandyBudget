//
//  CoredataStack.swift
//  HandyBudget
//
//  Created by Jadson on 03/12/2025.
//

import CoreData

class CoreDataStack {
    static let shared: CoreDataStack = .init()
    
    private init(){}
    
    lazy var container: NSPersistentContainer = {
        let p = NSPersistentContainer(name: "HandyBudget")
        p.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return p
    }()
    
    //Computed property
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print(nserror)
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
