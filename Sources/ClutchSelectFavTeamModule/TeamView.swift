//
//  SwiftUIView.swift
//  ClutchSelectFavTeamModule
//
//  Created by Engin Gülek on 26.10.2025.
//

import SwiftUI
import ClutchCoreKit
import Kingfisher
struct TeamView: View {
    let team : SelectFavTeam
    let borderColor : BorderColor
    let onTapGesture :()
    var body: some View {
        KFImage(URL(string: team.teamUrl)!)
            .resizable()
        
            .scaledToFit()
        
            .frame(width: 75, height: 75)
        
            .padding(10)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke( borderColor.value,
                             lineWidth: 2)
            ).onTapGesture {
                onTapGesture
               
             
            }
    }
}

