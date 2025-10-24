//
//  TeamListService.swift
//  ClutchSelectFavTeamModule
//
//  Created by Engin Gülek on 24.10.2025.
//
import Foundation
import ClutchManagerKits

protocol TeamListServiceProtocol: Sendable {
    func getSelectTeamList() async throws -> [SelectFavTeam]
}


final class TeamListService : TeamListServiceProtocol, @unchecked Sendable {
    private let networkManager : NetworkManagerProtocol = NetworkManager()
    
 
    func getSelectTeamList() async throws -> [SelectFavTeam] {
        do{
            let response = try await networkManager.execute(SelectFavTeamsRequest())
            return response.data
        }catch{
            throw error
        }
    }

}
