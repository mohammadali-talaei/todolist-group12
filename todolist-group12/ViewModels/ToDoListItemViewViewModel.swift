/*
    Mohammadali Talaei: 101400831
        Task:
            - Implemented the ToDoListItemViewViewModel class to handle interactions and data retrieval for individual to-do list items
            - Implemented the setupListener() method to listen for changes in the Firestore collection containing to-do items for the current user
            - Implemented the toggleIsDone() method to toggle the completion status of a to-do item and update it in the Firestore database
*/

import FirebaseAuth
import FirebaseFirestore
import Foundation

/// ViewModel for single to do list item view (each row in items list)
class ToDoListItemViewViewModel: ObservableObject {
    @Published var items: [ToDoListItem] = []
        
        private var userId: String
        private var listenerRegistration: ListenerRegistration?
        
        init(userId: String) {
            self.userId = userId
            setupListener()
        }
        
        func setupListener() {
            let todosRef = Firestore.firestore().collection("users").document(userId).collection("todos")
            listenerRegistration = todosRef.addSnapshotListener { [weak self] querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                self?.items = documents.compactMap { try? $0.data(as: ToDoListItem.self) }
            }
        }
    func toggleIsDone(item: ToDoListItem) {
        var itemCopy = item
        itemCopy.setDone(!item.isDone)

        guard let uid = Auth.auth().currentUser?.uid, let itemId = itemCopy.id else {
            print("Error: UID or Item ID is nil")
            return
        }

        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(itemId)
            .setData(itemCopy.asDictionary(), merge: true) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document successfully updated")
                }
            }
        
        if let index = items.firstIndex(where: { $0.id == item.id }) {
                    items[index].isDone.toggle() // This should trigger the UI to update
                }
    }

}
