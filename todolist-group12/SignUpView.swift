import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var navigatingToSignUp: Bool = false

    var body: some View {
        NavigationView {
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

                NavigationLink(destination: SignUpView(), isActive: $navigatingToSignUp) {
                    Button("Don't have an account? Sign Up") {
                        navigatingToSignUp = true
                    }
                }

                Button("Sign In") {
                    // Handle sign-in logic here
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
    }
}

struct SignUpView: View {
    var body: some View {
        Text("Sign Up")
        // Your sign-up view content here
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
