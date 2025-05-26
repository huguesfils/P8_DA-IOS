//
//  UserDataViewModel.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import Foundation
import CoreData

class UserDataViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var errorMessage: String? = nil
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
        fetchUserData()
    }
    
    func fetchUserData() {
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
