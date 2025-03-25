import Foundation

struct Game: Identifiable, Codable {
    let id: UUID
    var name: String
    var description: String?
    var isKidFriendly: Bool
    var contributorId: UUID
    
    init(id: UUID = UUID(), name: String, description: String? = nil, isKidFriendly: Bool, contributorId: UUID) {
        self.id = id
        self.name = name
        self.description = description
        self.isKidFriendly = isKidFriendly
        self.contributorId = contributorId
    }
} 