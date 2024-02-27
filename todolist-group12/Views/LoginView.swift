import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    @State private var isShowingSignUp: Bool = false
    @State private var isAuthenticated: Bool = false

    var body: some View {
        NavigationStack {
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
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(EdgeInsets(top: 5, leading: 6, bottom: 5, trailing: 6))

                    Button("Don't have an account? Sign Up") {
                        isShowingSignUp = true
                    }
                    .navigationDestination(isPresented: $isShowingSignUp) {
                        RegisterView()
                    }
                    
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
