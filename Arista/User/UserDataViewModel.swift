import Foundation
import CoreData

@MainActor
@Observable
final class UserDataViewModel {
    var firstName: String = ""
    var lastName: String = ""
    var errorMessage: String? = nil
    
    private let userRepository: UserRepositoryInterface
    
    init(userRepository: UserRepositoryInterface = UserRepository()) {
        self.userRepository = userRepository
        fetchUserData()
    }
    
    private func fetchUserData() {
        do {
            guard let user = try userRepository.getUser() else {
                errorMessage = "Aucun utilisateur trouvé."
                return
            }
            self.firstName = user.firstName ?? ""
            self.lastName = user.lastName ?? ""
        } catch {
            errorMessage = "Erreur lors de la récupération de l'utilisateur : \(error.localizedDescription)"
        }
    }
}
