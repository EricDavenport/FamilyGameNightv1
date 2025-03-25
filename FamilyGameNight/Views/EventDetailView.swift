import SwiftUI

struct EventDetailView: View {
    let event: Event
    @EnvironmentObject private var eventViewModel: EventViewModel
    @State private var showingAddFood = false
    @State private var showingAddGame = false
    @State private var newMessage = ""
    
    var body: some View {
        List {
            Section(header: Text("Event Details")) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(event.title)
                        .font(.title2)
                        .bold()
                    
                    HStack {
                        Image(systemName: "calendar")
                        Text(event.date, style: .date)
                        
                        Image(systemName: "clock")
                        Text(event.date, style: .time)
                    }
                    .foregroundColor(.secondary)
                    
                    HStack {
                        Image(systemName: "location")
                        Text(event.location)
                    }
                    .foregroundColor(.secondary)
                    
                    if event.isKidFriendly {
                        Label("Kid Friendly", systemImage: "figure.child")
                            .foregroundColor(.blue)
                    }
                }
            }
            
            Section(header: Text("Food & Drinks")) {
                ForEach(event.foodItems) { item in
                    FoodItemRow(item: item)
                }
                
                Button(action: { showingAddFood = true }) {
                    Label("Add Food Item", systemImage: "plus.circle.fill")
                }
            }
            
            Section(header: Text("Games")) {
                ForEach(event.games) { game in
                    GameRow(game: game)
                }
                
                Button(action: { showingAddGame = true }) {
                    Label("Add Game", systemImage: "plus.circle.fill")
                }
            }
            
            Section(header: Text("Chat")) {
                ForEach(event.chatMessages) { message in
                    ChatMessageRow(message: message)
                }
                
                HStack {
                    TextField("Type a message...", text: $newMessage)
                    Button(action: sendMessage) {
                        Image(systemName: "arrow.up.circle.fill")
                            .foregroundColor(.blue)
                    }
                    .disabled(newMessage.isEmpty)
                }
            }
        }
        .navigationTitle("Event Details")
        .sheet(isPresented: $showingAddFood) {
            AddFoodItemView(event: event)
        }
        .sheet(isPresented: $showingAddGame) {
            AddGameView(event: event)
        }
    }
    
    private func sendMessage() {
        // TODO: Replace with actual user ID when authentication is implemented
        let senderId = UUID()
        
        eventViewModel.addChatMessage(
            to: event,
            senderId: senderId,
            content: newMessage
        )
        
        newMessage = ""
    }
}

struct FoodItemRow: View {
    let item: FoodItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                if let description = item.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            if item.isHostProvided {
                Label("Host", systemImage: "house.fill")
                    .foregroundColor(.blue)
            }
        }
    }
}

struct GameRow: View {
    let game: Game
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(game.name)
                    .font(.headline)
                
                Spacer()
                
                if !game.isKidFriendly {
                    NoKidsSymbolView()
                }
            }
            
            if let description = game.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if game.isKidFriendly {
                Label("Kid Friendly", systemImage: "figure.child")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
        }
    }
}

struct ChatMessageRow: View {
    let message: ChatMessage
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(message.content)
                .font(.body)
            
            HStack {
                Text(message.timestamp, style: .time)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationView {
        EventDetailView(event: Event(
            title: "Sample Game Night",
            date: Date(),
            location: "123 Main St",
            isKidFriendly: true,
            hostId: UUID()
        ))
    }
    .environmentObject(EventViewModel())
} 