import SwiftUI

struct AddGameView: View {
    let event: Event
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var eventViewModel: EventViewModel
    
    @State private var name = ""
    @State private var description = ""
    @State private var isKidFriendly = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Game Details")) {
                    TextField("Game Name", text: $name)
                    TextField("Description (Optional)", text: $description)
                    Toggle("Kid Friendly", isOn: $isKidFriendly)
                }
            }
            .navigationTitle("Add Game")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addGame()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
    
    private func addGame() {
        // TODO: Replace with actual user ID when authentication is implemented
        let contributorId = UUID()
        
        eventViewModel.addGame(
            to: event,
            name: name,
            description: description.isEmpty ? nil : description,
            isKidFriendly: isKidFriendly,
            contributorId: contributorId
        )
        
        dismiss()
    }
}

#Preview {
    AddGameView(event: Event(
        title: "Sample Event",
        date: Date(),
        location: "123 Main St",
        isKidFriendly: true,
        hostId: UUID()
    ))
    .environmentObject(EventViewModel())
} 