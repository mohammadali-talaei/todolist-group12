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
    // Published property to control the visibility of the new item view
    @Published var showingNewItemView = false
    
    // Published property to control the visibility of the item edit view
    @Published var showingItemEdit = false
    
    // User ID associated with the to-do list
    private let userId: String
    
    // Initializes the view model with the user ID
    init(userId: String) {
        self.userId = userId
    }

    // CRUD Operations
    
    /// Deletes a to-do list item from Firestore
    /// - Parameter id: The ID of the item to delete
    func delete(id: String) {
        let db = Firestore.firestore()

        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
    
    /// Updates a to-do list item in Firestore
    /// - Parameters:
    ///   - id: The ID of the item to update
    ///   - newData: The updated data for the item
    func update(id: String, newData: [String: Any]) {
        let db = Firestore.firestore()

        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .setData(newData, merge: true)
    }
}
