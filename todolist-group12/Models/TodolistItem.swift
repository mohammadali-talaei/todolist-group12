import FirebaseFirestore

struct ToDoListItem: Codable, Identifiable {
    @DocumentID var id: String? // This is now optional and handled by Firestore
    var title: String
    var dueDate: Date
    var createdDate: Date
    var isDone: Bool

    // Default initializer
    init(id: String? = nil, title: String, dueDate: Date, createdDate: Date, isDone: Bool) {
        self.id = id
        self.title = title
        self.dueDate = dueDate
        self.createdDate = createdDate
        self.isDone = isDone
    }

    // Dictionary conversion for Firestore
    func asDictionary() -> [String: Any] {
        let dict: [String: Any] = [
            "title": title,
            "dueDate": dueDate,
            "createdDate": createdDate,
            "isDone": isDone
        ]
        return dict
    }
    
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}
