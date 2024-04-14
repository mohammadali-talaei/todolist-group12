/*
    Mahyar Ghasemi Khah: 101399392
        Tasks:
            - Implemented the LoginView SwiftUI component
            - Designed the layout and appearance of the login screen with input fields, buttons, and navigation
            - Integrated the LoginViewViewModel to handle login functionality and error messages
    Mohammadali Talaei: 101400831
        Tasks:
            - Assisted in refining the UI design and layout for improved user experience
            - Provided feedback on navigation flow and usability of the login screen
*/

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    @State private var isShowingSignUp: Bool = false
    @State private var isAuthenticated: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Mahyar Ghasemi Khah: 101399392")
                Text("Mohammadali Talaei: 101400831")
            }
            VStack {
                Image("welcome-image") // Replace with your actual image name
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text("TaskMaster")
                    .font(.largeTitle)
                    .bold()
                
                Text("Efficiently manage your tasks")
                    .font(.headline)
                    .foregroundColor(.gray)
                

                Form {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                    
                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(EdgeInsets(top: 5, leading: 6, bottom: 5, trailing: 6))
                        .listRowSeparator(.hidden)

                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(EdgeInsets(top: 5, leading: 6, bottom: 5, trailing: 6))
                        .listRowSeparator(.hidden)


                    Button("Don't have an account? Sign Up") {
                        isShowingSignUp = true
                    }
                    .navigationDestination(isPresented: $isShowingSignUp) {
                        RegisterView()
                    }
                    .listRowSeparator(.hidden)

                    
                    Button("Sign In") {
                        viewModel.login()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .scrollContentBackground(.hidden)
            }
        }
        .padding(30)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
