import SwiftUI

struct SettingsView: View {
    @StateObject private var userViewModel = UserViewModel()
    @State private var showingLogoutAlert = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Notifications")) {
                    Toggle("Enable Notifications", isOn: $userViewModel.isNotificationsEnabled)
                    if userViewModel.isNotificationsEnabled {
                        NavigationLink(destination: NotificationSettingsView()) {
                            Label("Notification Settings", systemImage: "bell.badge")
                        }
                    }
                }
                
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $userViewModel.isDarkModeEnabled)
                    Toggle("Show Kid-Friendly Events Only", isOn: $userViewModel.isKidFriendlyFilterEnabled)
                }
                
                Section(header: Text("Account")) {
                    NavigationLink(destination: PrivacySettingsView()) {
                        Label("Privacy Settings", systemImage: "lock.shield")
                    }
                    
                    NavigationLink(destination: HelpAndSupportView()) {
                        Label("Help & Support", systemImage: "questionmark.circle")
                    }
                    
                    Button(action: { showingLogoutAlert = true }) {
                        Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.red)
                    }
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Label("Version", systemImage: "info.circle")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    NavigationLink(destination: TermsAndConditionsView()) {
                        Label("Terms & Conditions", systemImage: "doc.text")
                    }
                    
                    NavigationLink(destination: PrivacyPolicyView()) {
                        Label("Privacy Policy", systemImage: "hand.raised")
                    }
                }
            }
            .navigationTitle("Settings")
            .alert("Sign Out", isPresented: $showingLogoutAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Sign Out", role: .destructive) {
                    // TODO: Implement sign out functionality
                }
            } message: {
                Text("Are you sure you want to sign out?")
            }
        }
    }
}

struct NotificationSettingsView: View {
    @State private var eventReminders = true
    @State private var chatNotifications = true
    @State private var updatesNotifications = true
    
    var body: some View {
        List {
            Toggle("Event Reminders", isOn: $eventReminders)
            Toggle("Chat Messages", isOn: $chatNotifications)
            Toggle("App Updates", isOn: $updatesNotifications)
        }
        .navigationTitle("Notifications")
    }
}

struct PrivacySettingsView: View {
    @State private var showProfileToEveryone = true
    @State private var showEmailToEveryone = false
    @State private var allowEventInvites = true
    
    var body: some View {
        List {
            Section(header: Text("Profile Privacy")) {
                Toggle("Show Profile to Everyone", isOn: $showProfileToEveryone)
                Toggle("Show Email to Everyone", isOn: $showEmailToEveryone)
            }
            
            Section(header: Text("Event Privacy")) {
                Toggle("Allow Event Invites", isOn: $allowEventInvites)
            }
        }
        .navigationTitle("Privacy")
    }
}

struct HelpAndSupportView: View {
    var body: some View {
        List {
            Section {
                NavigationLink(destination: FAQView()) {
                    Label("Frequently Asked Questions", systemImage: "questionmark.circle")
                }
                
                NavigationLink(destination: ContactSupportView()) {
                    Label("Contact Support", systemImage: "envelope")
                }
            }
            
            Section(header: Text("Resources")) {
                Link(destination: URL(string: "https://example.com/guide")!) {
                    Label("User Guide", systemImage: "book")
                }
                
                Link(destination: URL(string: "https://example.com/tutorials")!) {
                    Label("Tutorials", systemImage: "play.circle")
                }
            }
        }
        .navigationTitle("Help & Support")
    }
}

struct FAQView: View {
    var body: some View {
        List {
            Section(header: Text("General")) {
                FAQItem(question: "How do I create an event?",
                       answer: "Tap the + button on the Events tab to create a new event. Fill in the details and tap Create.")
                
                FAQItem(question: "How do I invite people?",
                       answer: "Once you've created an event, you can share the event link or invite specific people through the app.")
            }
            
            Section(header: Text("Account")) {
                FAQItem(question: "How do I change my profile picture?",
                       answer: "Go to your Profile tab, tap on your profile picture, and select a new photo from your device.")
                
                FAQItem(question: "How do I update my email?",
                       answer: "Go to your Profile tab, tap Edit Profile, and update your email address.")
            }
        }
        .navigationTitle("FAQ")
    }
}

struct FAQItem: View {
    let question: String
    let answer: String
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button(action: { isExpanded.toggle() }) {
                HStack {
                    Text(question)
                        .font(.headline)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
            }
            
            if isExpanded {
                Text(answer)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

struct ContactSupportView: View {
    @State private var subject = ""
    @State private var message = ""
    @State private var showingAlert = false
    
    var body: some View {
        Form {
            Section(header: Text("Message Details")) {
                TextField("Subject", text: $subject)
                TextEditor(text: $message)
                    .frame(height: 150)
            }
            
            Section {
                Button(action: sendMessage) {
                    Text("Send Message")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                }
                .listRowBackground(Color.blue)
                .disabled(subject.isEmpty || message.isEmpty)
            }
        }
        .navigationTitle("Contact Support")
        .alert("Message Sent", isPresented: $showingAlert) {
            Button("OK") {
                subject = ""
                message = ""
            }
        } message: {
            Text("Thank you for contacting support. We'll get back to you soon.")
        }
    }
    
    private func sendMessage() {
        // TODO: Implement message sending functionality
        showingAlert = true
    }
}

struct TermsAndConditionsView: View {
    var body: some View {
        ScrollView {
            Text("Terms and Conditions")
                .font(.title)
                .padding()
            
            Text("""
                Welcome to Family Game Night! By using our app, you agree to these terms and conditions.
                
                1. Acceptance of Terms
                By accessing and using this app, you accept and agree to be bound by the terms and conditions of this agreement.
                
                2. Use License
                Permission is granted to temporarily download one copy of the materials (information or software) on Family Game Night's website for personal, non-commercial transitory viewing only.
                
                [Add more terms and conditions as needed...]
                """)
                .padding()
        }
        .navigationTitle("Terms & Conditions")
    }
}

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            Text("Privacy Policy")
                .font(.title)
                .padding()
            
            Text("""
                This Privacy Policy describes how Family Game Night collects, uses, and handles your personal information.
                
                1. Information We Collect
                We collect information that you provide directly to us, including:
                - Name and contact information
                - Profile information
                - Event information
                
                2. How We Use Your Information
                We use the information we collect to:
                - Provide and maintain our services
                - Process your transactions
                - Send you technical notices and support messages
                
                [Add more privacy policy details as needed...]
                """)
                .padding()
        }
        .navigationTitle("Privacy Policy")
    }
}

#Preview {
    SettingsView()
} 