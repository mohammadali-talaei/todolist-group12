import SwiftUI

struct EditItemView: View {
    @Binding var item: ToDoListItem? // You would need to define the properties of ToDoListItem to match your data model
    @State private var taskName: String = ""
    @State private var taskDescription: String = ""
    @State private var taskCategory: String = "Personal"
    @State private var taskDueDate: Date = Date()
    @State private var taskTags: [String] = ["Business"]
    // Define more properties as needed for subtasks, etc.

    let categories = ["Personal", "Work", "Other"]
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task:")) {
                    TextField("Write a blog post", text: $taskName)
                    TextField("Provide a brief", text: $taskDescription)
                }

                Section(header: Text("Choose a")) {
                    Picker("Category", selection: $taskCategory) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section(header: Text("Set the")) {
                    DatePicker("Due Date", selection: $taskDueDate, displayedComponents: .date)
                }

                Section(header: Text("Tags")) {
                    // Replace with a custom view that allows adding and removing tags
                    ForEach(taskTags, id: \.self) { tag in
                        Text(tag)
                    }
                    Button(action: {
                        // Implement tag adding logic
                    }) {
                        Text("+ Add Tag")
                    }
                }

                Section(header: Text("Subtask:")) {
                    // Replace with a custom view that allows managing subtasks
                    Button(action: {
                        // Implement subtask adding logic
                    }) {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add a new subtask to the Task")
                        }
                    }
                }

                HStack {
                    Button("Delete task") {
                        // Implement delete task logic
                    }
                    .foregroundColor(.red)

                    Spacer()

                    Button("Save changes") {
                        // Implement save changes logic
                    }
                    .foregroundColor(.blue)
                }
            }
            .navigationBarItems(trailing: Button(action: {
                // Implement the dismiss action
                self.item = nil
            }) {
                Image(systemName: "xmark")
            })
            .navigationTitle("Edit Task")
        }
//        .onAppear {
//            if let item = item {
//                // Initialize the state variables with the item's properties
//                taskName = item.name
//                taskDescription = item.description
//                taskCategory = item.category
//                taskDueDate = item.dueDate
//                taskTags = item.tags
//                // Initialize other properties as needed
//            }
//        }
    }
}
