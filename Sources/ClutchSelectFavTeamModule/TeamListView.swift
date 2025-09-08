//
//  SwiftUIView.swift
//  ClutchSelectFavTeamModule
//
//  Created by Engin Gülek on 7.09.2025.
//

import SwiftUI
import ClutchCoreKit
import Kingfisher



struct TeamListView<VM:TeamListViewModelProtocol>: View {
    @StateObject var viewModel : VM
   private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    

    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    TextType(text: viewModel.textState.title, fontType: .titleSB)
                    TextType(text: viewModel.textState.subTitle, fontType: .titleTwoLight)
                    TextType(text: viewModel.selectedCountText, fontType: .titleTwoNormal)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.teamList, id: \.id) { team in
                            
                            KFImage(URL(string: team.image)!)
                                .resizable()
                            
                                .scaledToFit()
                            
                                .frame(width: 75, height: 75)
                            
                                .padding(10)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke( viewModel.teamBorderColor(id: "\(team.id)").value,
                                                 lineWidth: 2)
                                ).onTapGesture {
                                    viewModel.onTappedTeamIcon(id: "\(team.id)")
                                 
                                }
                            
                        }
                    }
                    .padding()
                }
            }
            
            BaseButton(
                text: viewModel.textState.countiuneButton,
                color: .white,
                backColor: viewModel.countiuneButton.backColor.value,
                fontType: .titleTwoNormal) {
                print("devam et")
            }.frame(width: .infinity)
                .disabled(viewModel.countiuneButton.disableState)
        }
        
    }
}

#Preview {
    TeamListView(viewModel:TeamListViewModel())
}

