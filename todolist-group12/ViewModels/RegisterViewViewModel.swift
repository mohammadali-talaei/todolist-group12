/*
    Mahyar Ghasemi Khah: 101399392
        Tasks:
            - Implemented the RegisterViewViewModel class to handle user registration
            - Created published properties for name, email, and password to store user input
            - Implemented the register() method to create a new user account with Firebase Authentication and insert user data into Firestore
            - Implemented the insertUserRecord() method to add user data to the Firestore database
            - Implemented the validate() method to perform basic validation checks on user input before registration
*/

import FirebaseFirestore
import FirebaseAuth
import Foundation

class RegisterViewViewModel: ObservableObject {
    // Published properties to store user registration input
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    
    // Registers a new user
    func register() {
        guard validate() else {
            return
        }

        // Create user with email and password using Firebase Auth
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let userId = result?.user.uid else {
                return
            }

            // Insert user record into Firestore database
            self?.insertUserRecord(id: userId)
        }
    }
    
    // Inserts user record into Firestore database
    private func insertUserRecord(id: String) {
        // Create a new User object
        let newUser = User(
            id: id,
            name: name,
            email: email,
            joined: Date().timeIntervalSince1970
        )

        // Access Firestore and set user data in the "users" collection
        let db = Firestore.firestore()
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }

    // Validates name, email, and password input
    private func validate() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }

        guard email.contains("@") && email.contains(".") else {
            return false
        }

        guard password.count >= 6 else {
            return false
        }

        return true
    }
}
