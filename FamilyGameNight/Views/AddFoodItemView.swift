import SwiftUI

struct AddFoodItemView: View {
    let event: Event
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var eventViewModel: EventViewModel
    
    @State private var name = ""
    @State private var description = ""
    @State private var isHostProvided = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Food Item Details")) {
                    TextField("Name", text: $name)
                    TextField("Description (Optional)", text: $description)
                    Toggle("Host Provided", isOn: $isHostProvided)
                }
            }
            .navigationTitle("Add Food Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addFoodItem()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
    
    private func addFoodItem() {
        // TODO: Replace with actual user ID when authentication is implemented
        let contributorId = isHostProvided ? event.hostId : UUID()
        
        eventViewModel.addFoodItem(
            to: event,
            name: name,
            description: description.isEmpty ? nil : description,
            isHostProvided: isHostProvided,
            contributorId: contributorId
        )
        
        dismiss()
    }
}

#Preview {
    AddFoodItemView(event: Event(
        title: "Sample Event",
        date: Date(),
        location: "123 Main St",
        isKidFriendly: true,
        hostId: UUID()
    ))
    .environmentObject(EventViewModel())
} 