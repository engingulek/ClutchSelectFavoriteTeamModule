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
    func getUuidFromDatabase() async throws -> String
    func addFavTeam(uuid:String,teams:[Int]) async throws
}


final class TeamListService : TeamListServiceProtocol, @unchecked Sendable {
   
    
    private let networkManager : NetworkManagerProtocol = NetworkManager()
    private let userInfoManager : UserInfoManagerProtocol = UserInfoManager()
 
    func getSelectTeamList() async throws -> [SelectFavTeam] {
        do{
            let response = try await networkManager.execute(SelectFavTeamsRequest())
            return response.data
        }catch{
            throw error
        }
    }
    
    
    func getUuidFromDatabase() async throws -> String {
        do{
            let userInfo = try await userInfoManager.getUser()
            return userInfo.uuid
        }catch{
            throw error
        }
    }
    
    func addFavTeam(uuid:String,teams:[Int]) async throws {
        do{
            let response = try await networkManager.execute(AddFavTeamsRequest(uuid: uuid, teams: teams))
            print("Add fav team response \(response.message)")
        }catch{
            throw error
        }
    }

}
