import Foundation

struct Event: Identifiable, Codable {
    let id: UUID
    var title: String
    var date: Date
    var location: String
    var isKidFriendly: Bool
    var hostId: UUID
    var foodItems: [FoodItem]
    var games: [Game]
    var chatMessages: [ChatMessage]
    
    init(id: UUID = UUID(), title: String, date: Date, location: String, isKidFriendly: Bool, hostId: UUID) {
        self.id = id
        self.title = title
        self.date = date
        self.location = location
        self.isKidFriendly = isKidFriendly
        self.hostId = hostId
        self.foodItems = []
        self.games = []
        self.chatMessages = []
    }
} 