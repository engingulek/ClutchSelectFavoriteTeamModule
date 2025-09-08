// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import SwiftUI
import ClutchModularProtocols


//MARK: - ClutchSelectFavTeamModule

public class ClutchSelectFavTeamModule : @preconcurrency SelectFavoriteTeamModuleProtocol {
    public init() { }
    
    @MainActor  public func createSelecteFavoriteTeamModule() -> AnyView {
        let view = TeamListView(viewModel: TeamListViewModel())
        return AnyView(view)
    }
}
