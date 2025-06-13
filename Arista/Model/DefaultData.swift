import Foundation
import CoreData

struct DefaultData {
    let viewContext: NSManagedObjectContext
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
    
    func apply() throws {
        let userRepository = UserRepository(viewContext: viewContext)
        let sleepRepository = SleepRepository(viewContext: viewContext)
        if (try? userRepository.getUser()) == nil {
            let initialUser = UserEntity(context: viewContext)
            initialUser.firstName = "Charlotte"
            initialUser.lastName = "Razoul"
            
            if try sleepRepository.getSleepSessions().isEmpty {
                let sleep1 = SleepEntity(context: viewContext)
                let sleep2 = SleepEntity(context: viewContext)
                let sleep3 = SleepEntity(context: viewContext)
                let sleep4 = SleepEntity(context: viewContext)
                let sleep5 = SleepEntity(context: viewContext)
                
                let timeIntervalForADay: TimeInterval = 60 * 60 * 24
                
                sleep1.duration = (0...900).randomElement()!
                sleep1.startTime = Date(timeIntervalSinceNow: timeIntervalForADay*5)
                sleep1.user = initialUser
                sleep1.id = UUID()
                sleep1.quality = Int32.random(in: 1...10)
                
                sleep2.duration = (0...900).randomElement()!
                sleep2.startTime = Date(timeIntervalSinceNow: timeIntervalForADay*4)
                sleep2.user = initialUser
                sleep2.id = UUID()
                sleep2.quality = Int32.random(in: 1...10)
                
                sleep3.duration = (0...900).randomElement()!
                sleep3.startTime = Date(timeIntervalSinceNow: timeIntervalForADay*3)
                sleep3.user = initialUser
                sleep3.id = UUID()
                sleep3.quality = Int32.random(in: 1...10)
                
                sleep4.duration = (0...900).randomElement()!
                sleep4.startTime = Date(timeIntervalSinceNow: timeIntervalForADay*2)
                sleep4.user = initialUser
                sleep4.id = UUID()
                sleep4.quality = Int32.random(in: 1...10)
                
                sleep5.duration = (0...900).randomElement()!
                sleep5.startTime = Date(timeIntervalSinceNow: timeIntervalForADay)
                sleep5.user = initialUser
                sleep5.id = UUID()
                sleep5.quality = Int32.random(in: 1...10)
            }
            
            try? viewContext.save()
        }
    }
}
