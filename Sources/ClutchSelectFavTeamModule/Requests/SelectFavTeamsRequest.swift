//
//  SelectFavTeamsRequest.swift
//  ClutchSelectFavTeamModule
//
//  Created by Engin Gülek on 24.10.2025.
//

import ClutchManagerKits

struct SelectFavTeamsRequest: NetworkRequest {
    typealias Response = DataResponse<[SelectFavTeam]>

    var path: NetworkPath { .selectFavTeams }
    var method: AlamofireMethod { .GET }
    var headers: [String: String]? {
        ["Authorization": "Bearer 123456"]
    }
    var parameters: [String : Any]? { nil }
}
