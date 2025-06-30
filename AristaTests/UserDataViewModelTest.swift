import Foundation
import Testing
@testable import Arista

@MainActor
struct UserDataViewModelTest {
    @Test
    func testFetchUserDataSuccess() async throws {
        let container = CoreDataMock.makeInMemoryContainer()
        let context = container.viewContext
        let user = UserEntity(context: context)
        user.firstName = "Jean"
        user.lastName = "Dupont"
        try context.save()
        let repo = UserRepository(viewContext: context)
        let viewModel = UserDataViewModel(userRepository: repo)
        #expect(viewModel.firstName == "Jean")
        #expect(viewModel.lastName == "Dupont")
        #expect(viewModel.errorMessage == nil)
    }

    @Test
    func testFetchUserDataNoUser() async throws {
        let container = CoreDataMock.makeInMemoryContainer()
        let context = container.viewContext
        let repo = UserRepository(viewContext: context)
        let viewModel = UserDataViewModel(userRepository: repo)
        #expect(viewModel.firstName == "")
        #expect(viewModel.lastName == "")
        #expect(viewModel.errorMessage == "Aucun utilisateur trouvé.")
    }

    @Test
    func testFetchUserDataError() async throws {
        let container = CoreDataMock.makeInMemoryContainer()
        let context = container.viewContext
        let repo = UserRepository(viewContext: context)
        let viewModel = UserDataViewModel(userRepository: repo)
        #expect(viewModel.errorMessage == "Aucun utilisateur trouvé.")
    }

    @Test
    func testFetchUserDataEmptyNames() async throws {
        let container = CoreDataMock.makeInMemoryContainer()
        let context = container.viewContext
        let user = UserEntity(context: context)
        user.firstName = ""
        user.lastName = ""
        try context.save()
        let repo = UserRepository(viewContext: context)
        let viewModel = UserDataViewModel(userRepository: repo)
        #expect(viewModel.firstName == "")
        #expect(viewModel.lastName == "")
        #expect(viewModel.errorMessage == nil)
    }

    @Test
    func testFetchUserDataRepositoryError() async throws {
        final class FailingUserRepository: UserRepositoryInterface {
            func getUser() throws -> UserEntity? { throw NSError(domain: "Test", code: 1, userInfo: nil) }
        }
        let viewModel = UserDataViewModel(userRepository: FailingUserRepository())
        #expect(viewModel.errorMessage?.contains("Erreur lors de la récupération de l'utilisateur") == true)
    }
}
