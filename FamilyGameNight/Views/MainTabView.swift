import SwiftUI

struct MainTabView: View {
    @StateObject private var eventViewModel = EventViewModel()
    @StateObject private var userViewModel = UserViewModel()
    
    var body: some View {
        TabView {
            EventsView()
                .tabItem {
                    Label("Events", systemImage: "calendar")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .environmentObject(eventViewModel)
        .environmentObject(userViewModel)
    }
}

#Preview {
    MainTabView()
} 