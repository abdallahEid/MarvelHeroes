//
//  CoreDataController.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/3/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    
    let persistentContainer:NSPersistentContainer
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    // load store
    func load(completion: @escaping () -> Void ) {
        persistentContainer.loadPersistentStores { (pesistentStoreDescription, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            completion()
        }
    }
    
    // access context
    var viewContext:NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
}

extension DataController {
    func autoSaveViewContext(timeInterval: TimeInterval = 30){
        guard timeInterval > 0 else {
            print("cannot set negative interval")
            return
        }
        
        if viewContext.hasChanges {
            saveViewContext()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
            self.autoSaveViewContext(timeInterval: timeInterval)
        }
    }
    
    func saveViewContext(){
        try? viewContext.save()
    }
}
