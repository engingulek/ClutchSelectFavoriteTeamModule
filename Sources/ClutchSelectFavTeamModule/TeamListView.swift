//
//  SwiftUIView.swift
//  ClutchSelectFavTeamModule
//
//  Created by Engin Gülek on 7.09.2025.
//

import SwiftUI
import ClutchCoreKit
import Kingfisher


@MainActor
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
                        ForEach(viewModel.selectFavTeams, id: \.teamID) { team in
                            
                            KFImage(URL(string: team.teamUrl)!)
                                .resizable()
                            
                                .scaledToFit()
                            
                                .frame(width: 75, height: 75)
                            
                                .padding(10)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke( viewModel.teamBorderColor(id: team.teamID).value,
                                                 lineWidth: 2)
                                ).onTapGesture {
                                    viewModel.onTappedTeamIcon(id: team.teamID)
                                 
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
                    viewModel.onTappedContinueButton()
            }.frame(width: .infinity)
                .disabled(viewModel.countiuneButton.disableState)
        }.task {
           await viewModel.taskAction()
        } .alert(viewModel.alerTitle, isPresented: $viewModel.showAlertState) {
         
        } message: {
            Text(viewModel.showAlertMessage)
        }
        
    }
}

#Preview {
    TeamListView(viewModel:TeamListViewModel())
}

