//
//  ContentView.swift
//  CoreDataMVVMDemo
//
//  Created by Paulo Orquillo on 13/08/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var taskVM = TaskVM()

    var body: some View {
        VStack {
            HStack {
                TextField("Enter Task", text: $taskVM.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Save") {
                    taskVM.save()
                    taskVM.getAllTasks()
                }
            }
            
            List {
                ForEach(taskVM.tasks, id:\.id) {task in
                    Text(task.title)
                }.onDelete(perform: { indexSet in
                    taskVM.deleteTask(of: indexSet)
                })
            }
            
        }.padding()
        .onAppear(perform: {
            taskVM.getAllTasks()
        })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
