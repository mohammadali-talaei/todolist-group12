/*
    Mohammadali Talaei: 101400831
        Task:
            - Implemented the MainViewViewModel class to manage the user's authentication status and current user ID
            - Used Firebase Auth to monitor changes in the authentication state
            - Set up a property to determine whether a user is signed in
*/
import FirebaseAuth
import Foundation

class MainViewViewModel: ObservableObject {
    // The current user's ID
    @Published var currentUserId: String = ""
    
    // Handle for observing changes in authentication state
    private var handler: AuthStateDidChangeListenerHandle?
    
    // Initializes the view model and sets up the authentication state listener
    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    // Determines if the user is signed in
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
