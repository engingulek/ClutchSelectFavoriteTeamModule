//
//  Untitled.swift
//  ClutchSelectFavTeamModule
//
//  Created by Engin Gülek on 7.09.2025.
//
import Foundation
import ClutchCoreKit

@MainActor
protocol TeamListViewModelProtocol: ObservableObject {
    var selectedTeamIDs: Set<Int> { get }
    var favoriteTeams: [SelectFavTeam] { get }
    var selectedCountText: String { get }
    var textState: TextState { get }
    var continueButtonState: (isDisabled: Bool, background: CountiuneButtonBackColor) { get }
    var showAlert: Bool { get set }
    var alertMessage: String { get }

    var teamFetchError: (state:Bool, message:String) { get }
    var isLoading: Bool { get }
    
    var toHomePage: (() -> Void)? { get set }
    
    func toggleTeamSelection(id: Int)
    func borderColor(for id: Int) -> BorderColor
    func tapContinue()
    func task() async
  
}

final class TeamListViewModel: TeamListViewModelProtocol {
    
    // MARK: - Dependencies
    private let service: TeamListServiceProtocol
    
    // MARK: - Published Properties
    @Published var continueButtonState: (
        isDisabled: Bool,
        background: CountiuneButtonBackColor) = (true, .disable)
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var favoriteTeams: [SelectFavTeam] = []
    @Published var teamFetchError: (state:Bool, message:String) = (false,"")
    @Published var isLoading: Bool = true
    @Published private(set) var selectedTeamIDs: Set<Int> = []
    @Published private(set) var selectedCount: Int = 0
    @Published private(set) var selectedCountText: String = "0/2"

    // MARK: - Other Properties
    private var uuid: String?
    var textState: TextState = TextState()
    var toHomePage: (() -> Void)?
    // MARK: - Init
    init(service: TeamListServiceProtocol = TeamListService()) {
        self.service = service
    }

    // MARK: - Lifecycle Actions
    func task() async {
        await fetchTeams()
        await fetchUserID()
    }

    // MARK: - User Actions
    func toggleTeamSelection(id: Int) {
        if selectedTeamIDs.contains(id) {
            selectedTeamIDs.remove(id)
            selectedCount -= 1
        } else if selectedTeamIDs.count < 2 {
            selectedTeamIDs.insert(id)
            selectedCount += 1
        }
        updateSelectionUI()
    }
    
    func tapContinue() {
        Task {
            guard let uuid else { return }
            do {
                let selected = Array(selectedTeamIDs)
                try await service.addFavTeam(uuid: uuid, teams: selected)
                toHomePage?()
            } catch {
                showAlert(with: LocalizableTheme.unExpectedError.localized)
            }
        }
    }

    func borderColor(for id: Int) -> BorderColor {
        selectedTeamIDs.contains(id) ? .selected : .notSelected
    }
    
 
}

extension TeamListViewModel {
    // MARK: - Private Helpers
    private func updateSelectionUI() {
        selectedCountText = "\(selectedCount)/2"
        continueButtonState = (
            isDisabled: selectedTeamIDs.count < 2,
            background: selectedTeamIDs.count < 2 ? .disable : .able
        )
    }
    
    private func fetchUserID() async {
        do {
            uuid = try await service.getUuidFromDatabase()
        } catch {
            showAlert(with: LocalizableTheme.unExpectedError.localized)
        }
    }
    
    private func fetchTeams() async {
        do {
            favoriteTeams = try await service.getSelectTeamList()
        } catch {
            teamFetchError = (state:true,message:LocalizableTheme.unExpectedError.localized)
        }
        isLoading = false
    }

    private func showAlert(with message: String) {
        alertMessage = message
        showAlert = true
    }
}
