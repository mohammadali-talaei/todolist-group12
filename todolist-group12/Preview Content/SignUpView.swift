import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var fullName: String = ""
    @State private var navigatingToSignIn: Bool = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.crop.circle.badge.plus") // Replace with your actual sign-up image or icon
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .padding(.top, 50)
            
            Text("Create an Account")
                .font(.largeTitle)
                .bold()
            
            TextField("Full Name", text: $fullName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("Email Address", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button("Get Started") {
                // Handle sign-up logic here
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.purple) // Change to your app's theme color
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)

            Spacer()
            
            Button("Already have an account? Sign In") {
                dismiss()
            }
            .padding(.bottom, 50)
        }
        .navigationBarHidden(true)
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
