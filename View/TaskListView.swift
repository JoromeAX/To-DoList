//
//  TaskListView.swift
//  To-DoList
//
//  Created by Roman Khancha on 11.10.2024.
//

import SwiftUI
import SwiftData

struct TaskListView: View {
    
    @Environment(\.modelContext) var context
    
    @Query var tasks: [Task]
    
    @State private var sortOption: SortOption = .priority
    @State private var isPresentingAddEditTaskView = false
    @State private var selectedTask: Task?
    
    var sortedTasks: [Task] {
        switch sortOption {
        case .date:
            return tasks.sorted { $0.date < $1.date }
        case .priority:
            return tasks.sorted { $0.priority > $1.priority }
        }
    }
    
    var body: some View {
        NavigationView {
            
            VStack {
                Picker("Sort by", selection: $sortOption) {
                    Text("Priority").tag(SortOption.priority)
                    Text("Date").tag(SortOption.date)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                List {
                    ForEach(sortedTasks) { task in
                        Button {
                            selectedTask = task
                            isPresentingAddEditTaskView.toggle()
                        } label: {
                            VStack(alignment: .leading) {
                                Text(task.tittle)
                                    .font(.headline)
                                if let details = task.details {
                                    Text(details)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                
                                HStack {
                                    Text("Priority: \(task.priority)")
                                    Spacer()
                                    Text(task.date, style: .date)
                                }
                                .font(.footnote)
                            }
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
                .navigationTitle("Tasks")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            selectedTask = nil
                            isPresentingAddEditTaskView.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $isPresentingAddEditTaskView) {
                AddEditTaskView(task: selectedTask ?? Task(tittle: "", priority: 1, date: Date()))
            }
        }
    }
    
    private func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            let task = sortedTasks[index]
            context.delete(task)
        }
        try? context.save()
    }
}
