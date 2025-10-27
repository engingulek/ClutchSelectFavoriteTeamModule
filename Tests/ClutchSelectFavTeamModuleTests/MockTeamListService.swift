//
//  MockTeamListService.swift
//  ClutchSelectFavTeamModule
//
//  Created by Engin Gülek on 27.10.2025.
//

@testable import ClutchSelectFavTeamModule

import Foundation

final class MockTeamListService: TeamListServiceProtocol,@unchecked Sendable {
    
    // MARK: - Test Control Properties
    
    /// Mocked response for getSelectTeamList()
    var mockTeamList: [SelectFavTeam] = []
    
    /// Mocked response for getUuidFromDatabase()
    var mockUuid: String = "test-uuid"
    
    /// Flag to verify if addFavTeam() is called
    var addFavTeamCalled = false
    
    var teamListError = false
    
    var uuidError = false
    
    var addFavTeamError = false
    
    /// Error to be thrown when shouldThrowError is true
    var mockError: Error = NSError(domain: "MockError", code: -1)
    
    // MARK: - Protocol Methods
    
    func getSelectTeamList() async throws -> [SelectFavTeam] {
        if teamListError {
            throw mockError
        }
        return mockTeamList
    }
    
    func getUuidFromDatabase() async throws -> String {
        if uuidError {
            throw mockError
        }
        return mockUuid
    }
    
    func addFavTeam(uuid: String, teams: [Int]) async throws {
        /// Mark that this method was called
        addFavTeamCalled = true
        
        if addFavTeamError {
            throw mockError
        }
      
    }
}



