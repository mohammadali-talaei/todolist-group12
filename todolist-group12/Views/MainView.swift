/*
    Mohammadali Talaei: 101400831
        Tasks:
            - Implemented the MainView SwiftUI component
            - Integrated the MainViewViewModel to manage user authentication and display appropriate views based on authentication status
            - Designed the layout and appearance of the MainView with a tab view including Home, Calendar, and Profile sections
*/
import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()

    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            accountView
        } else {
            LoginView()
        }
    }

    @ViewBuilder
    var accountView: some View {
        TabView {
            ToDoListView(userId: viewModel.currentUserId)
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            CalendarView(userId: viewModel.currentUserId)
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
