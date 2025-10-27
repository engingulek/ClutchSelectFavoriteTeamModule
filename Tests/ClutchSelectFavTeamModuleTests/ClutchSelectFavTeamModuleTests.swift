
import Testing
@testable import ClutchSelectFavTeamModule
import ClutchCoreKit

@Suite("Test For Select Favorite Team Module")

@MainActor
class ClutchSelectFavTeamModuleTests {
    private var service: MockTeamListService!
    private var viewModel: TeamListViewModel!
    
    init() {
        service = .init()
        viewModel = .init(service: service)
    }
    
    @Test("isLoading should be true on start and false after fetching teams")
    func testLoadingStateDuringFetch() async throws {
        #expect(viewModel.isLoading == true)
        service.mockTeamList = [
            .init(teamID: 1, teamUrl: "team url"),
            .init(teamID: 2, teamUrl: "team url")
        ]
        await viewModel.task()
        try await Task.sleep(nanoseconds: 200_000_000)
        #expect(viewModel.isLoading == false)
    }
    
    @Test("teamFetchError should be true if service returns error")
    func testTeamFetchError() async throws {
        #expect(viewModel.teamFetchError.state == false)
        #expect(viewModel.teamFetchError.message == "")
        service.teamListError = true
        await viewModel.task()
        try await Task.sleep(nanoseconds: 200_000_000)
        #expect(viewModel.teamFetchError.state == true)
        #expect(viewModel.teamFetchError.message == LocalizableTheme.unExpectedError.localized)
    }
    
    @Test("Continue button should be disabled when page opens")
    func testContinueButtonInitialState() async throws {
        service.mockTeamList = [
            .init(teamID: 1, teamUrl: "team url"),
            .init(teamID: 2, teamUrl: "team url")
        ]
        await viewModel.task()
        try await Task.sleep(nanoseconds: 200_000_000)
        #expect(viewModel.continueButtonState.isDisabled == true)
        #expect(viewModel.continueButtonState.background == .disable)
    }
    
    @Test("Continue button remains disabled if only one team is selected")
    func testSingleTeamSelection() async throws {
        service.mockTeamList = [
            .init(teamID: 1, teamUrl: "team url"),
            .init(teamID: 2, teamUrl: "team url")
        ]
        await viewModel.task()
        viewModel.toggleTeamSelection(id: 1)
        try await Task.sleep(nanoseconds: 200_000_000)
        #expect(viewModel.continueButtonState.isDisabled == true)
        #expect(viewModel.continueButtonState.background == .disable)
    }
    
    @Test("Continue button should be enabled when two teams are selected")
    func testTwoTeamSelection() async throws {
        service.mockTeamList = [
            .init(teamID: 1, teamUrl: "team url"),
            .init(teamID: 2, teamUrl: "team url")
        ]
        await viewModel.task()
        viewModel.toggleTeamSelection(id: 1)
        viewModel.toggleTeamSelection(id: 2)
        try await Task.sleep(nanoseconds: 200_000_000)
        #expect(viewModel.continueButtonState.isDisabled == false)
        #expect(viewModel.continueButtonState.background == .able)
    }
    
    @Test("Continue button should be disabled after deselecting one team")
    func testTwoTeamsThenRemoveOne() async throws {
        service.mockTeamList = [
            .init(teamID: 1, teamUrl: "team url"),
            .init(teamID: 2, teamUrl: "team url")
        ]
        await viewModel.task()
        viewModel.toggleTeamSelection(id: 1)
        viewModel.toggleTeamSelection(id: 2)
        viewModel.toggleTeamSelection(id: 1)
        try await Task.sleep(nanoseconds: 200_000_000)
        #expect(viewModel.continueButtonState.isDisabled == true)
        #expect(viewModel.continueButtonState.background == .disable)
    }
    
    @Test("Show alert when UUID error occurs")
    func testUuidErrorShowsAlert() async throws {
        #expect(viewModel.showAlert == false)
        #expect(viewModel.alertMessage == "")
        service.uuidError = true
        await viewModel.task()
        try await Task.sleep(nanoseconds: 200_000_000)
        #expect(viewModel.showAlert == true)
        #expect(viewModel.alertMessage == LocalizableTheme.unExpectedError.localized)
    }
    
    @Test("Show alert when tapping continue fails")
    func testContinueTapReturnsError() async throws {
        #expect(viewModel.showAlert == false)
        #expect(viewModel.alertMessage == "")
        service.addFavTeamError = true
        await viewModel.task()
        viewModel.tapContinue()
        try await Task.sleep(nanoseconds: 200_000_000)
        #expect(viewModel.showAlert == true)
        #expect(viewModel.alertMessage == LocalizableTheme.unExpectedError.localized)
    }
}
