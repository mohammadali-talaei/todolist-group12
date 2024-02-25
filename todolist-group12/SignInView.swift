import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isShowingSignUp: Bool = false

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

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
