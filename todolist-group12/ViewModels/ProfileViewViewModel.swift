/*
    Mohammadali Talaei: 101400831
        Task:
            - Implemented the ProfileViewViewModel class to handle fetching user data and logging out
            - Created a published property user to store user information fetched from Firestore
            - Implemented the fetchUser() method to retrieve user data from Firestore based on the current user's ID
            - Implemented the logOut() method to sign out the current user from Firebase Authentication
*/

import FirebaseAuth
import FirebaseFirestore
import Foundation

class ProfileViewViewModel: ObservableObject {
    // Published property to hold user profile data
    @Published var user: User? = nil
    
    // Fetches user profile data from Firestore
    func fetchUser() {
        // Get the current user's ID
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        // Access Firestore and fetch user document
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }

            // Update user property with fetched data
            DispatchQueue.main.async {
                self?.user = User(
                    id: data["id"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    joined: data["joined"] as? TimeInterval ?? 0
                )
            }
        }
    }
    
    // Logs out the current user
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}
