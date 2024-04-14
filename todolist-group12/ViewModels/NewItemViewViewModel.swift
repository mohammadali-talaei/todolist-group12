/*
    Mahyar Ghasemi Khah: 101399392
        Tasks:
            - Implemented the NewItemViewViewModel class to handle the creation and saving of new to-do items
            - Created published properties for title, dueDate, and showAlert to track user input and display alerts
            - Implemented the save() method to validate input and save the new to-do item to Firestore
            - Implemented the canSave property to determine whether the input is valid and can be saved
*/
import FirebaseAuth
import FirebaseFirestore
import Foundation

class NewItemViewViewModel: ObservableObject {
    // Title of the new item
    @Published var title = ""
    
    // Due date of the new item
    @Published var dueDate: Date = Date()
    
    // Flag to control whether to show an alert
    @Published var showAlert = false
    
    // Initializes the view model
    init() {}

    // MARK: - Save Method
    
    // Saves the new to-do list item
    func save() {
        // Check if the item can be saved
        guard canSave else {
            return
        }

        // Get the current user's ID
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }

        // Create a new to-do list item model
        let newId = UUID().uuidString
        let newItem = ToDoListItem(
            id: newId,
            title: title,
            dueDate: dueDate,
            createdDate: Date(),
            isDone: false
        )

        // Save the new item to Firestore
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("todos")
            .document(newId)
            .setData(newItem.asDictionary())
    }
    
    // Checks if the new item can be saved
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }

        guard dueDate >= Date() else {
            return false
        }

        return true
    }
}
