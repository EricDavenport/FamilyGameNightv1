import Foundation
import Combine

class UserViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var isNotificationsEnabled = true
    @Published var isDarkModeEnabled = false
    @Published var isKidFriendlyFilterEnabled = true
    
    // MARK: - User Management
    
    func updateProfile(name: String, email: String, profileImageURL: String? = nil) {
        guard let userId = currentUser?.id else { return }
        currentUser = User(id: userId, name: name, email: email, profileImageURL: profileImageURL)
    }
    
    // MARK: - Settings Management
    
    func toggleNotifications() {
        isNotificationsEnabled.toggle()
    }
    
    func toggleDarkMode() {
        isDarkModeEnabled.toggle()
    }
    
    func toggleKidFriendlyFilter() {
        isKidFriendlyFilterEnabled.toggle()
    }
} 