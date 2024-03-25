import FirebaseFirestoreSwift
import SwiftUI

struct ToDoListView: View {
    @StateObject var viewModel: ToDoListViewViewModel
    @FirestoreQuery var items: [ToDoListItem]
    @State private var selectedItem: ToDoListItem?
    
    let userId: String // Add userId as a property
    
    init(userId: String) {
        self.userId = userId // Initialize userId
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
                    // Pass userId to ToDoListItemView
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
                Button {
                    // Action
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
                
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPresented: $viewModel.showingNewItemView)
            }
            .sheet(item: $selectedItem) { item in
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
