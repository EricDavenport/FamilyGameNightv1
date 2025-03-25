import Foundation
import Combine

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var selectedEvent: Event?
    @Published var isLoading = false
    @Published var error: Error?
    
    // MARK: - Event Management
    
    func createEvent(title: String, date: Date, location: String, isKidFriendly: Bool, hostId: UUID) {
        let newEvent = Event(title: title, date: date, location: location, isKidFriendly: isKidFriendly, hostId: hostId)
        events.append(newEvent)
        selectedEvent = newEvent
    }
    
    func addFoodItem(to event: Event, name: String, description: String?, isHostProvided: Bool, contributorId: UUID?) {
        guard let index = events.firstIndex(where: { $0.id == event.id }) else { return }
        let foodItem = FoodItem(name: name, description: description, isHostProvided: isHostProvided, contributorId: contributorId)
        events[index].foodItems.append(foodItem)
        updateSelectedEvent()
    }
    
    func addGame(to event: Event, name: String, description: String?, isKidFriendly: Bool, contributorId: UUID) {
        guard let index = events.firstIndex(where: { $0.id == event.id }) else { return }
        let game = Game(name: name, description: description, isKidFriendly: isKidFriendly, contributorId: contributorId)
        events[index].games.append(game)
        updateSelectedEvent()
    }
    
    func addChatMessage(to event: Event, senderId: UUID, content: String) {
        guard let index = events.firstIndex(where: { $0.id == event.id }) else { return }
        let message = ChatMessage(eventId: event.id, senderId: senderId, content: content)
        events[index].chatMessages.append(message)
        updateSelectedEvent()
    }
    
    // MARK: - Helper Methods
    
    private func updateSelectedEvent() {
        if let eventId = selectedEvent?.id,
           let updatedEvent = events.first(where: { $0.id == eventId }) {
            selectedEvent = updatedEvent
        }
    }
} 