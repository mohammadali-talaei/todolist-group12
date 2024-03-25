import FirebaseFirestoreSwift
import SwiftUI

struct CalendarView: View {
    @State var currentDate: Date = Date()
    @FirestoreQuery var items: [ToDoListItem]
    var userId: String

    // Initialize ToDoListItemViewViewModel with userId
    @StateObject var viewModel: ToDoListItemViewViewModel

    init(userId: String) {
        self.userId = userId
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos"
        )
        self._viewModel = StateObject(
            wrappedValue: ToDoListItemViewViewModel(userId: userId)
        )
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                CustomDatePicker(currentDate: $currentDate, userId: userId)
            }
        }
    }
}

#Preview {
    CalendarView(userId: "RcNUw88NDCOuzwgBeispLnTTLuv2")
}
