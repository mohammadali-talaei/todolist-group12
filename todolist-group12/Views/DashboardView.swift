import SwiftUI

struct DashboardView: View {
    @Binding var selectedTab: Int
    var body: some View {
        TabView (selection: $selectedTab) {
            NavigationView {
                MyHabitsView()
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            .tag(0)

//            NavigationView {
//                SearchView()
//            }
//            .tabItem {
//                Label("Search", systemImage: "magnifyingglass")
//            }

//            NavigationView {
//                SettingsView()
//            }
//            .tabItem {
//                Label("Settings", systemImage: "gear")
//            }
        }
    }
}
