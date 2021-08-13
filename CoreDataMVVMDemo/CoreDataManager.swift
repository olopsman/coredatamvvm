//
//  CoreDataManager.swift
//  CoreDataMVVMDemo
//
//  Created by Paulo Orquillo on 13/08/21.
//

import SwiftUI
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    //singleton
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: Operations
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error)
        }
    }
    func getTaskById(id: NSManagedObjectID) -> Task? {
        do {
            return try viewContext.existingObject(with: id) as? Task
        } catch {
            return nil
        }
    }
    
    func delete(task: Task) {
        viewContext.delete(task)
        save()
    }
    
    func fetchTasks() -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    private init(){
        persistentContainer = NSPersistentContainer(name: "CoreDataMVVMDemo")
        persistentContainer.loadPersistentStores(completionHandler: {(description, error) in
            if let error = error {
                fatalError("Cannot initialize CoreData \(error)")
            }
        })
    }
}
