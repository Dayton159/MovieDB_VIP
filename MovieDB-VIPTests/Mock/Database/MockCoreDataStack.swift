//
//  MockCoreDataStack.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 21/01/22.
//

import CoreData
@testable import MovieDB_VIP

class MockCoreDataStack: CoreDataStack {
  override init() {
    super.init()
    
    let persistentStoreDescription = NSPersistentStoreDescription()
    persistentStoreDescription.type = NSInMemoryStoreType
    
    let container = NSPersistentContainer(
      name: CoreDataStack.name)
    container.persistentStoreDescriptions = [persistentStoreDescription]
    
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    
    persistentContainer = container
  }
}
