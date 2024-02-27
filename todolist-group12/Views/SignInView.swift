import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isShowingSignUp: Bool = false
    @State private var isAuthenticated: Bool = false
    @State private var selectedTab: Int = 0  // Default to the first tab
    
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
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Don't have an account? Sign Up") {
                    isShowingSignUp = true
                }
                .navigationDestination(isPresented: $isShowingSignUp) {
                    SignUpView()
                }
                
                Button("Sign In") {
                    signIn() // Call the sign-in method
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(10)
                

                .fullScreenCover(isPresented: $isAuthenticated) {
//                    DashboardView(selectedTab: $selectedTab)
                }
            }
            .padding()
        }
    }
    
    func signIn() {
        // Validate the email and password
        // This is a placeholder for your actual authentication logic
        if !email.isEmpty && !password.isEmpty {
            // Simulate successful authentication
            isAuthenticated = true
        } else {
            // Handle validation failure, show an error message, etc.
        }
    }
}
