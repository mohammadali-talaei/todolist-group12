/* 
 Mahyar Ghasemi Khah: 101399392
    Tasks:
        -   Implemented the logic for making the request to firebase
 Mohammadali Talaei: 101400831
    Task:
        - Drafted the UI and set the states for integration
 */
import SwiftUI

struct EditItemView: View {
    @Binding var item: ToDoListItem? // You would need to define the properties of ToDoListItem to match your data model
    @ObservedObject var viewModel: ToDoListViewViewModel 
    @State private var title: String = ""
    @State private var dueDate: Date = Date()

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task:")) {
                    TextField("Write a blog post", text: $title)
                }

                Section(header: Text("Set the")) {
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                }


                HStack {
                    Button(action: {
                        // First, check that the `item` exists and has an `id`.
                        if var currentItem = item, let itemId = currentItem.id {
                            currentItem.title = title
                            currentItem.dueDate = dueDate

                            // Convert the item to a dictionary using your `asDictionary` method.
                            let itemData = currentItem.asDictionary()

                            // Call a method in your view model to update the item in Firestore.
                            viewModel.update(id: itemId, newData: itemData)

                            // Dismiss the edit view by setting the `item` to nil.
                            item = nil
                        } else {
                            // Handle the error: the item is nil or doesn't have an id.
                            print("Item is nil or doesn't have a valid ID.")
                        }
                    }) {
                        Text("Save changes")
                    }

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
        .onAppear {
            if let currentItem = item {
                title = currentItem.title
                dueDate = currentItem.dueDate
            }
        }
    }
}
