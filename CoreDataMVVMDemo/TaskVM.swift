//
//  TaskVM.swift
//  CoreDataMVVMDemo
//
//  Created by Paulo Orquillo on 13/08/21.
//

import Foundation
import CoreData

class TaskVM: ObservableObject {
    var title: String = ""
    @Published var tasks: [TaskModel] = []
    
    // MARK: Intents
    func getAllTasks() {
        tasks = CoreDataManager.shared.fetchTasks().map(TaskModel.init)
    }
    
    func save() {
        let task = Task(context: CoreDataManager.shared.viewContext)
        task.title = title
        CoreDataManager.shared.save()
    }
    
    func deleteTask(of offsets: IndexSet) {
        offsets.forEach() { index in
            let task = tasks[index]
            delete(task)
        }
    }
    
    func delete(_ task: TaskModel) {
        let existingTask = CoreDataManager.shared.getTaskById(id: task.id)
        if let existingTask = existingTask {
            CoreDataManager.shared.delete(task: existingTask)
            getAllTasks()
        }
    }
}

struct TaskModel {
    let task: Task
    var id: NSManagedObjectID {
        return task.objectID
    }
    var title: String {
        return task.title ?? ""
    }
}
