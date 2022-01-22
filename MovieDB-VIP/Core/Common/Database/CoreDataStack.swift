//
//  CoreDataStack.swift
//  MovieDB-VIP
//
//  Created by Dayton on 21/01/22.
//

import CoreData

class CoreDataStack {
  init() {}
  static let shared = CoreDataStack()
  static let name = "MovieDB-VIP"
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: CoreDataStack.name)
    
    container.loadPersistentStores { (_, error) in
      guard let error = error as NSError? else { return }
      fatalError("Unresolved error: \(error), \(error.userInfo)")
    }
    
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.undoManager = nil
    container.viewContext.shouldDeleteInaccessibleFaults = true
    container.viewContext.automaticallyMergesChangesFromParent = true
    
    return container
  }()
}

extension CoreDataStack {
  func context() -> NSManagedObjectContext {
    let taskContext = persistentContainer.newBackgroundContext()
    taskContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    taskContext.undoManager = nil
    
    return taskContext
  }
}
