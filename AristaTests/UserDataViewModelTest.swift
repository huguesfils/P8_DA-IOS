import Foundation
import Testing
@testable import Arista

final class MockUserRepository: UserRepositoryInterface {
    var userToReturn: UserEntity? = nil
    var shouldThrow = false
    func getUser() throws -> UserEntity? {
        if shouldThrow { throw NSError(domain: "Test", code: 1, userInfo: nil) }
        return userToReturn
    }
}

@MainActor
struct UserDataViewModelTest {
    @Test
    func testFetchUserDataSuccess() async throws {
        let mockRepo = MockUserRepository()
        let user = UserEntity(context: PersistenceController.shared.container.viewContext)
        user.firstName = "Jean"
        user.lastName = "Dupont"
        mockRepo.userToReturn = user
        let viewModel = UserDataViewModel(userRepository: mockRepo)
        #expect(viewModel.firstName == "Jean")
        #expect(viewModel.lastName == "Dupont")
        #expect(viewModel.errorMessage == nil)
    }

    @Test
    func testFetchUserDataNoUser() async throws {
        let mockRepo = MockUserRepository()
        mockRepo.userToReturn = nil
        let viewModel = UserDataViewModel(userRepository: mockRepo)
        #expect(viewModel.firstName == "")
        #expect(viewModel.lastName == "")
        #expect(viewModel.errorMessage == "Aucun utilisateur trouvé.")
    }

    @Test
    func testFetchUserDataError() async throws {
        let mockRepo = MockUserRepository()
        mockRepo.shouldThrow = true
        let viewModel = UserDataViewModel(userRepository: mockRepo)
        #expect(viewModel.errorMessage?.contains("Erreur lors de la récupération de l'utilisateur") == true)
    }
}
