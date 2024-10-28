//
//  AddEditTaskView.swift
//  To-DoList
//
//  Created by Roman Khancha on 11.10.2024.
//

import SwiftUI
import SwiftData

struct AddEditTaskView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @State var task: Task

    var body: some View {
        Form {
            TextField("Tittle", text: $task.tittle)
            TextField("Details", text: Binding(
                get: { task.details ?? ""},
                set: { task.details = $0.isEmpty ? nil : $0 }
            ))
            Stepper(value: $task.priority, in: 1...5) {
                Text("Priority: \(task.priority)")
            }
            DatePicker("Date", selection: $task.date, displayedComponents: .date)
            
            Button("Save") {
                context.insert(task)
                
                try? context.save()
                dismiss()
            }
        }
    }
}
