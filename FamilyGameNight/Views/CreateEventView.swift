import SwiftUI

struct CreateEventView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var eventViewModel: EventViewModel
    
    @State private var title = ""
    @State private var date = Date()
    @State private var location = ""
    @State private var isKidFriendly = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Event Title", text: $title)
                    DatePicker("Date & Time", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    TextField("Location", text: $location)
                    Toggle("Kid Friendly", isOn: $isKidFriendly)
                }
            }
            .navigationTitle("New Game Night")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        createEvent()
                    }
                    .disabled(title.isEmpty || location.isEmpty)
                }
            }
        }
    }
    
    private func createEvent() {
        // TODO: Replace with actual user ID when authentication is implemented
        let hostId = UUID()
        
        eventViewModel.createEvent(
            title: title,
            date: date,
            location: location,
            isKidFriendly: isKidFriendly,
            hostId: hostId
        )
        
        dismiss()
    }
}

#Preview {
    CreateEventView()
        .environmentObject(EventViewModel())
} 