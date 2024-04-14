/*
    Mahyar Ghasemi Khah: 101399392
        Tasks:
            - Integrated the ProfileViewViewModel to fetch user data and handle logout functionality
    Mohammadali Talaei: 101400831
        Tasks:
            - Implemented the ProfileView SwiftUI component
            - Designed the layout and appearance of the profile screen including user information and logout button
*/

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    Text("Loading Profile...")
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }

    @ViewBuilder
    func profile(user: User) -> some View {
        Image(systemName: "person.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color.blue)
            .frame(width: 125, height: 125)
            .padding()

        // Info: Name, Email, Member since
        VStack(alignment: .leading) {
            HStack {
                Text("Name: ")
                    .bold()

                Text(user.name)
            }
            .padding()
            HStack {
                Text("Email: ")
                    .bold()
                Text(user.email)
            }
            .padding()
            HStack {
                Text("Member Since: ")
                    .bold()
                Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
            }
            .padding()
        }
        .padding()

        // Sign out
        Button("Log Out") {
            viewModel.logOut()
        }
        .tint(.red)
        .padding()

        Spacer()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
