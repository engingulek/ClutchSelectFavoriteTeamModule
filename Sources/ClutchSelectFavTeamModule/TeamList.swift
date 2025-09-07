//
//  SwiftUIView.swift
//  ClutchSelectFavTeamModule
//
//  Created by Engin Gülek on 7.09.2025.
//

import SwiftUI
import ClutchCoreKit
import Kingfisher

struct Team {
    let id = UUID()
    let image:String
    
}


struct SwiftUIView: View {
    let totalCircles = 20
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    let list : [Team] = [
        Team(image: "https://upload.wikimedia.org/wikipedia/tr/2/2e/Liverpool_FC_logo_2024.png"),
        Team(image: "https://upload.wikimedia.org/wikipedia/tr/thumb/9/92/Arsenal_Football_Club.png/330px-Arsenal_Football_Club.png"),
        Team(image: "https://upload.wikimedia.org/wikipedia/tr/thumb/f/f6/Manchester_City.png/300px-Manchester_City.png")
        
        
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                TextType(text: "What is Your Favorite Team?", fontType: .titleSB)
                TextType(text: "Select 3 teams to customize the home feed", fontType: .titleTwoLight)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(list, id: \.id) { team in
                        
                        KFImage(URL(string: team.image)!)
                            .resizable()
                        
                            .scaledToFit()
                           
                            .frame(width: 75, height: 75)
                        
                            .padding(10)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                        
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    SwiftUIView()
}

