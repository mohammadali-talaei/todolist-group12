/*
    Mohammadali Talaei: 101400831
        Tasks:
            - Implemented the ToDoListItemView SwiftUI component
            - Designed the layout and appearance of the ToDoListItemView with title, due date, and completion toggle button
*/

import SwiftUI

struct ToDoListItemView: View {
    // View model to handle interactions and data operations for the to-do item
    @StateObject var viewModel: ToDoListItemViewViewModel
    
    // The to-do item to display
    let item: ToDoListItem
    
    // The user ID associated with the to-do item
    let userId: String
        
    // Initializes the view with a to-do item and user ID
    init(item: ToDoListItem, userId: String) {
        self.item = item
        self.userId = userId
        
        // Initializes the view model with the user ID
        self._viewModel = StateObject(wrappedValue: ToDoListItemViewViewModel(userId: userId))
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                // Displays the title of the to-do item
                Text(item.title)
                    .font(.body)
                
                // Displays the due date of the to-do item
                Text("\(item.dueDate.formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            
            Spacer()
            
            // Button to toggle the completion status of the to-do item
            Button {
                viewModel.toggleIsDone(item: item)
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color.blue)
            }
        }
    }
}
