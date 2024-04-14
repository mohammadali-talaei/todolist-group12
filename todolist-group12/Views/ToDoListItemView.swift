/*
    Mohammadali Talaei: 101400831
        Tasks:
            - Implemented the ToDoListItemView SwiftUI component
            - Designed the layout and appearance of the ToDoListItemView with title, due date, and completion toggle button
*/

import SwiftUI

struct ToDoListItemView: View {
    @StateObject var viewModel: ToDoListItemViewViewModel
    let item: ToDoListItem
    let userId: String // Add userId as a property

    init(item: ToDoListItem, userId: String) {
        self.item = item
        self.userId = userId
        self._viewModel = StateObject(wrappedValue: ToDoListItemViewViewModel(userId: userId))
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.body)

                Text("\(item.dueDate.formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }

            Spacer()

            Button {
                viewModel.toggleIsDone(item: item)
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color.blue)
            }
        }
    }
}
