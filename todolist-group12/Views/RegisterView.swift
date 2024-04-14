/*
    Mahyar Ghasemi Khah: 101399392
        Tasks:
            - Designed the layout and appearance of the register screen including input fields and buttons
    Mohammadali Talaei: 101400831
        Tasks:
            - Implemented the RegisterView SwiftUI component
            - Integrated the RegisterViewViewModel to handle user registration functionality
*/

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
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
            
            TextField("Full Name", text: $viewModel.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("Email Address", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button("Get Started") {
                viewModel.register()
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
