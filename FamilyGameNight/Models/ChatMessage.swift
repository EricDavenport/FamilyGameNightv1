import Foundation

struct ChatMessage: Identifiable, Codable {
    let id: UUID
    let eventId: UUID
    let senderId: UUID
    var content: String
    let timestamp: Date
    
    init(id: UUID = UUID(), eventId: UUID, senderId: UUID, content: String, timestamp: Date = Date()) {
        self.id = id
        self.eventId = eventId
        self.senderId = senderId
        self.content = content
        self.timestamp = timestamp
    }
} 