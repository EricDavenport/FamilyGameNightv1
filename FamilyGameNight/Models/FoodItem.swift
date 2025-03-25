import Foundation

struct FoodItem: Identifiable, Codable {
    let id: UUID
    var name: String
    var description: String?
    var isHostProvided: Bool
    var contributorId: UUID?
    
    init(id: UUID = UUID(), name: String, description: String? = nil, isHostProvided: Bool, contributorId: UUID? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.isHostProvided = isHostProvided
        self.contributorId = contributorId
    }
} 