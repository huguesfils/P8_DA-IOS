import Foundation

struct Sleep: Identifiable {
    let id: UUID
    let startTime: Date
    let duration: Int32
    let quality: Int
    
    init?(entity: SleepEntity) {
        guard let id = entity.id, let startTime = entity.startTime else {
            return nil
        }
        self.id = id
        self.startTime = startTime
        self.duration = entity.duration
        self.quality = Int(entity.quality)
    }
}
