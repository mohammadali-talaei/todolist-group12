/*
    Mahyar Ghasemi Khah: 101399392
        Tasks:
            - Implemented the LoginViewViewModel class to handle user login functionality
            - Validated email and password fields to ensure they are not empty and have valid formats
            - Integrated Firebase Auth for user authentication using email and password
*/

import FirebaseAuth
import Foundation

class LoginViewViewModel: ObservableObject {
    // Email entered by the user
    @Published var email = ""
    
    // Password entered by the user
    @Published var password = ""
    
    // Error message to display if login fails
    @Published var errorMessage = ""
    
    // Initializes the view model
    init() {}
    
    // Validates user input and attempts to log in with provided credentials
    func login() {
        guard validate() else {
            return
        }

        // Try log in
        Auth.auth().signIn(withEmail: email, password: password)
    }    
    // Validates the email and password fields
    private func validate() -> Bool {
        errorMessage = ""
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }

        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter valid email."
            return false
        }

        return true
    }
}
