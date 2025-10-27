//
//  SwiftUIView.swift
//  ClutchSelectFavTeamModule
//
//  Created by Engin Gülek on 7.09.2025.
//

import SwiftUI
import ClutchCoreKit
import Kingfisher
import ClutchNavigationKit

@MainActor
struct TeamListView<VM: TeamListViewModelProtocol>: View {
    @StateObject var viewModel: VM
    @EnvironmentObject private var navigation:Navigation
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        VStack {
            if viewModel.isLoading{
                VStack {
                    ProgressView("Yükleniyor...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                   
                }
            }else {
                if viewModel.teamFetchError.state  {
                    //TODO: move to core kit
                  
                } else {
                    VStack {
                        ScrollView {
                            VStack {
                                TextType(text: viewModel.textState.title, fontType: .titleSB)
                                TextType(text: viewModel.textState.subTitle, fontType: .titleTwoLight)
                                TextType(text: viewModel.selectedCountText, fontType: .titleTwoNormal)
                                
                                LazyVGrid(columns: columns, spacing: 20) {
                                    ForEach(viewModel.favoriteTeams, id: \.teamID) { team in
                                        TeamView(
                                            team: team,
                                            borderColor: viewModel.borderColor(for: team.teamID)
                                        ) {
                                            viewModel.toggleTeamSelection(id: team.teamID)
                                        }
                                    }
                                }
                                .padding()
                            }
                        }
                        
                        BaseButton(
                            text: viewModel.textState.countiuneButton,
                            color: .white,
                            backColor: viewModel.continueButtonState.background.value,
                            fontType: .titleTwoNormal
                        ) {
                            viewModel.tapContinue()
                        }
                        .frame(width: .infinity)
                        .disabled(viewModel.continueButtonState.isDisabled)
                    }
                }
            }
        }
        .onAppear {
            viewModel.toHomePage = {
                navigation.push(.tabView)
            }
        }
        .task {
            await viewModel.task()
        }
        .simpleAlert(
            isPresented: $viewModel.showAlert,
            title: viewModel.textState.alertTitle,
            message: viewModel.alertMessage
        )
    }
    
    private var errorText: some View {
        Text(viewModel.teamFetchError.message)
            .font(.title)
            .foregroundColor(.red)
            .fontWeight(.semibold)
    }
}


#Preview {
    TeamListView(viewModel:TeamListViewModel())
}


