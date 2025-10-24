//
//  Untitled.swift
//  ClutchSelectFavTeamModule
//
//  Created by Engin Gülek on 7.09.2025.
//
import Foundation

@MainActor
protocol TeamListViewModelProtocol : ObservableObject {
    var selectedTeam : Set<Int> {get}
    var selectFavTeams : [SelectFavTeam]{get}
    var selectCount : Int {get}
    var selectedCountText:String {get}
    var textState:TextState {get}
    var countiuneButton : (disableState:Bool,backColor:CountiuneButtonBackColor) {get}
    
    func onTappedTeamIcon(id:Int)
    func teamBorderColor(id:Int) -> BorderColor
    func onTappedContinueButton()
    func taskAction() async
}


class TeamListViewModel : TeamListViewModelProtocol {
    var service : TeamListServiceProtocol = TeamListService()
   @Published var countiuneButton: (disableState: Bool, backColor: CountiuneButtonBackColor)
    = (disableState:true,backColor:CountiuneButtonBackColor.disable)
    var selectedTeam: Set<Int> = []
    var textState: TextState = TextState()
    var selectedCountText: String = "0/2"
    
  
    
    @Published var selectFavTeams : [SelectFavTeam] = []
    
    
  @Published  var selectCount: Int = 0
    

    func taskAction() async {
        do {
            let list = try await service.getSelectTeamList()
            selectFavTeams = list
        }catch{
            print("view model error list fav")
        }
      
    }
    
    
    func onTappedTeamIcon(id: Int) {
        if selectedTeam.contains(id) {
            selectedTeam.remove(id)
            
            selectCount -= 1
        }else{
            if selectedTeam.count < 2 {
                selectedTeam.insert(id)
                selectCount += 1
            }
            
        }
        
       selectedCountText = "\(selectCount)/2"
        countiuneButton = (
            disableState:selectedTeam.count == 0,
            backColor:selectedTeam.count == 0 ? CountiuneButtonBackColor.disable : CountiuneButtonBackColor.able
        )
            
        
    }
    
    
    func teamBorderColor(id: Int) -> BorderColor {
        return selectedTeam.contains(id)
        ? BorderColor.selected
        : BorderColor.notSelected
    }
    
    func onTappedContinueButton() {
        Task {
            do {
                let userId = try await service.getUuidFromDatabase()
                print("\(userId), \(selectedTeam)")
            }catch{
                print("get user id \(error.localizedDescription)")
            }
        }
    }
}
