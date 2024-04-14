/*
    Mahyar Ghasemi Khah: 101399392
        Tasks:
            - Implemented the ToDoListView SwiftUI component
            - Integrated the ToDoListViewViewModel to fetch and manage to-do list items
            - Designed the layout and appearance of the ToDoListView with a list of to-do items, delete and edit swipe actions, and a button to add new items
*/

import FirebaseFirestoreSwift
import SwiftUI

struct ToDoListView: View {
    // View model for managing the to-do list view
    @StateObject var viewModel: ToDoListViewViewModel
    
    // Query to fetch to-do list items from Firestore
    @FirestoreQuery var items: [ToDoListItem]
    
    // Selected to-do item
    @State private var selectedItem: ToDoListItem?
    
    // User ID associated with the to-do list
    let userId: String
    
    // Initializes the to-do list view with a user ID
    init(userId: String) {
        self.userId = userId
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos"
        )
        self._viewModel = StateObject(
            wrappedValue: ToDoListViewViewModel(userId: userId)
        )
    }
    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
                    // Display each to-do item in the list
                    ToDoListItemView(item: item, userId: userId)
                        .swipeActions {
                            Button("Delete") {
                                viewModel.delete(id: item.id!)
                            }
                            .tint(.red)
                            Button("Edit") {
                                self.selectedItem = item
                            }
                            .tint(.gray)
                        }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("To Do List")
            .toolbar {
                // Button to add new to-do items
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
                
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                // Sheet to present the new item view
                NewItemView(newItemPresented: $viewModel.showingNewItemView)
            }
            .sheet(item: $selectedItem) { item in
                // Sheet to present the edit item view
                EditItemView(item: $selectedItem, viewModel: viewModel)
            }
        }
    }
}

struct ToDoListItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(userId: "RcNUw88NDCOuzwgBeispLnTTLuv2")
    }
}
