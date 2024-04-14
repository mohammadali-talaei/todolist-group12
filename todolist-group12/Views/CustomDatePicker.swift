/*
    Mahyar Ghasemi Khah: 101399392
        Tasks:
            - Designed and implemented the UI layout, including the calendar grid and navigation controls
            - Implemented state management for integrating the date picker component with parent views
    Mohammadali Talaei: 101400831
        Tasks:
            - Implemented fetching and displaying todos for the selected date from Firestore
            - Assisted in refining the UI design and layout for improved user experience
*/
import SwiftUI
import FirebaseFirestore


struct CustomDatePicker: View {
    // Binding to allow this date to be shared with parent views.
    @Binding var currentDate: Date
    var userId: String
    // Simple month adjustment to navigate through months.
    @State private var monthOffset = 0
    
    private var calendar: Calendar {
            Calendar.current
    }
    
    // Property to store fetched to-dos
    @State private var todosForSelectedDate: [ToDoListItem] = []
    
    var body: some View {
        VStack(spacing: 20) {
            // Weekday headers
            let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // Dates grid
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(daysInCurrentMonth(), id: \.self) { date in
                    Text("\(calendar.component(.day, from: date))")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(isSameDay(date1: date, date2: currentDate) ? Color.blue : Color.clear)
                        .cornerRadius(8)
                        .onTapGesture {
                            currentDate = date
                        }
                }
            }
            
            // Month navigation
            HStack {
                Button(action: {
                    monthOffset -= 1
                }) {
                    Image(systemName: "chevron.left")
                }
                
                Button(action: {
                    monthOffset += 1
                }) {
                    Image(systemName: "chevron.right")
                }
            }
        }
        .padding()
        .onChange(of: monthOffset) { _ in
            // Update the current date when changing months
            if let newDate = Calendar.current.date(byAdding: .month, value: monthOffset, to: Date()) {
                currentDate = newDate
            }
        }
        Text("\(selectedDateString)")
                        .font(.title2)
                        .fontWeight(.bold)
        
        List(todosForSelectedDate) { todo in
                    Text(todo.title)
                }
                .onChange(of: currentDate) { _ in
                    fetchTodosForSelectedDate()
                }
                .onAppear(perform: fetchTodosForSelectedDate)
                .frame(height: 300)
    }
    
    private func fetchTodosForSelectedDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let dateString = dateFormatter.string(from: currentDate)

        // Assuming startOfDay and endOfDay are midnight and just before midnight of the next day
        guard let startOfDay = dateFormatter.date(from: dateString),
              let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) else {
            fatalError("Couldn't calculate start and end of day.")
        }

        print("Fetching todos from \(startOfDay) to \(endOfDay) for user \(userId)")

        let todosRef = Firestore.firestore().collection("users").document(userId).collection("todos")
        todosRef.whereField("dueDate", isGreaterThanOrEqualTo: startOfDay)
                 .whereField("dueDate", isLessThan: endOfDay)
                 .getDocuments { (querySnapshot, err) in
                     if let err = err {
                         print("Error getting documents: \(err)")
                     } else if let documents = querySnapshot?.documents {
                         print("Fetched \(documents.count) todos.")
                         self.todosForSelectedDate = documents.compactMap { document -> ToDoListItem? in
                             try? document.data(as: ToDoListItem.self)
                         }
                     }
                 }
    }


    
    // Helper to get the current month and year string
    private var currentMonthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: Calendar.current.date(byAdding: .month, value: monthOffset, to: Date())!)
    }
    
    // Helper to get a string representation of the selected date
    private var selectedDateString: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, yyyy"
            return formatter.string(from: currentDate)
        }
    
    // Helper to list all days in the current month
    private func daysInCurrentMonth() -> [Date] {
        guard let monthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate)),
              let monthEnd = calendar.date(byAdding: .month, value: 1, to: monthStart),
              let range = calendar.range(of: .day, in: .month, for: monthStart) else {
            return []
        }
        
        return range.compactMap { day -> Date? in
            calendar.date(byAdding: .day, value: day - 1, to: monthStart)
        }.filter { $0 < monthEnd }
    }

    
    // Helper to check if two dates are the same day
    private func isSameDay(date1: Date, date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
}
