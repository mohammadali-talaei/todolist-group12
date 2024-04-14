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
    @Published var title = ""
    @Published var dueDate: Date = Date()
    @Published var showAlert = false

    init() {}

    func save() {
        guard canSave else {
            return
        }

        // Get current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }

        // Create model
        let newId = UUID().uuidString
        let newItem = ToDoListItem(
            id: newId,
            title: title,
            dueDate: dueDate,
            createdDate: Date(),
            isDone: false
        )

        // Save model
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("todos")
            .document(newId)
            .setData(newItem.asDictionary())
    }

    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty  else {
            return false
        }

        guard dueDate >= Date() else {
            return false
        }

        return true
    }
}
