/*
    Mahyar Ghasemi Khah: 101399392
        Tasks:
            - Implemented the ToDoListViewViewModel class to manage interactions and data operations for the list of to-do items
            - Implemented the delete() method to delete a to-do item from the Firestore database based on its ID
            - Implemented the update() method to update a to-do item in the Firestore database with new data
*/

import FirebaseFirestore
import Foundation

/// ViewModel for list of items view
/// Primary tab
class ToDoListViewViewModel: ObservableObject {
    @Published var showingNewItemView = false
    @Published var showingItemEdit = false

    private let userId: String

    init(userId: String) {
        self.userId = userId
    }

    /// Delete to do list item
    /// - Parameter id: Item id to delete
    func delete(id: String) {
        let db = Firestore.firestore()

        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
    func update(id: String, newData: [String: Any]) {
            let db = Firestore.firestore()

            db.collection("users")
                .document(userId)
                .collection("todos")
                .document(id)
                .setData(newData, merge: true)
    }
}
