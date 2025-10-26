//
//  AddFavTeamRequest.swift
//  ClutchSelectFavTeamModule
//
//  Created by Engin Gülek on 26.10.2025.
//
import ClutchManagerKits

struct AddFavTeamsRequest: NetworkRequest {
    typealias Response = CreatedResponse

    var path: NetworkPath { .addFavTeam }
    var method: AlamofireMethod { .POST }
    var headers: [String: String]?
   
    var parameters: [String : Any]?
    
    init(uuid: String,teams:[Int]) {
        self.parameters = ["uuid": uuid,"teams":teams]
       }
}
