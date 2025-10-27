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
            if viewModel.teamsFetchError {
                    VStack {
                        errorMessage
                    }
                }else{
                    VStack {
                       
                        ScrollView {
                            VStack {
                                TextType(text: viewModel.textState.title, fontType: .titleSB)
                                TextType(text: viewModel.textState.subTitle, fontType: .titleTwoLight)
                                TextType(text: viewModel.selectedCountText, fontType: .titleTwoNormal)
                                
                                LazyVGrid(columns: columns, spacing: 20) {
                                    ForEach(viewModel.selectFavTeams, id: \.teamID) { team in
                                        TeamView(
                                            team: team, borderColor:
                                                viewModel.teamBorderColor(id: team.teamID),
                                            onTapGesture: viewModel.onTappedTeamIcon(id: team.teamID))
                                        
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
                    }
                }
            
           
            
        }.task {
           await viewModel.taskAction()
        }.simpleAlert(
            isPresented: $viewModel.showAlertState,
            title: viewModel.alerTitle,
            message: viewModel.showAlertMessage)
    }
    
    
    var errorMessage: some View {
        Text(viewModel.showAlertMessage)
            .font(.title)
            .foregroundStyle(.black)
    }
}

#Preview {
    TeamListView(viewModel:TeamListViewModel())
}

