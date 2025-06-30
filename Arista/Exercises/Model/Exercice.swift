import Foundation

struct Exercise: Identifiable {
    let id: UUID
    let type: String
    let duration: Int32
    let intensity: Int32
    let date: Date
    
    init?(entity: ExerciseEntity) {
        guard let id = entity.id,
              let type = entity.type,
              let date = entity.date else {
            return nil
        }
        self.id = id
        self.type = type
        self.duration = entity.duration
        self.intensity = entity.intensity
        self.date = date
    }
}
