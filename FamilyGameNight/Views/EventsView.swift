import SwiftUI

struct EventsView: View {
    @EnvironmentObject private var eventViewModel: EventViewModel
    @State private var showingCreateEvent = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(eventViewModel.events) { event in
                    NavigationLink(destination: EventDetailView(event: event)) {
                        EventRowView(event: event)
                    }
                }
            }
            .navigationTitle("Game Nights")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingCreateEvent = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingCreateEvent) {
                CreateEventView()
            }
        }
    }
}

struct EventRowView: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(event.title)
                    .font(.headline)
                
                Spacer()
                
                if !event.isKidFriendly {
                    NoKidsSymbolView()
                }
            }
            
            HStack {
                Image(systemName: "calendar")
                Text(event.date, style: .date)
                
                Image(systemName: "clock")
                Text(event.date, style: .time)
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: "location")
                Text(event.location)
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            
            if event.isKidFriendly {
                Label("Kid Friendly", systemImage: "figure.child")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    EventsView()
        .environmentObject(EventViewModel())
} 