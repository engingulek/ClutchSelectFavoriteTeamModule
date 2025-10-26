//
//  Untitled.swift
//  ClutchSelectFavTeamModule
//
//  Created by Engin Gülek on 7.09.2025.
//
import Foundation
import ClutchCoreKit
@MainActor
protocol TeamListViewModelProtocol : ObservableObject {
    var selectedTeam : Set<Int> {get}
    var selectFavTeams : [SelectFavTeam]{get}
    var selectCount : Int {get}
    var selectedCountText:String {get}
    var textState:TextState {get}
    var countiuneButton : (disableState:Bool,backColor:CountiuneButtonBackColor) {get}
    var showAlertState:Bool {get set}
    var showAlertMessage:String {get}
    var alerTitle:String {get}
    var buttonText:String {get}
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
    @Published var showAlertState:Bool  = false
    @Published var showAlertMessage:String  = ""
    private var uuid:String? = nil
    var buttonText: String = LocalizableTheme.ok.localized
    var alerTitle: String = LocalizableTheme.warning.localized
  
    
    @Published var selectFavTeams : [SelectFavTeam] = []
    
    
  @Published  var selectCount: Int = 0
    
    
   private func getUserId() async {
        Task {
            do {
                 uuid = try await service.getUuidFromDatabase()
               
            }catch{
               
                createAlertMessage()
            }
        }
    }
    
    
    private func createAlertMessage() {
        showAlertState = true
        showAlertMessage = LocalizableTheme.unExpectedError.localized
    }
    
   private func fetchList() async {
        do {
            let list = try await service.getSelectTeamList()
            selectFavTeams = list
        }catch{
            createAlertMessage()
        }
    }
    

    func taskAction() async {
        await getUserId()
        await fetchList()
        
      
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
                guard let uuid else {return}
              try await service.addFavTeam(uuid: uuid, teams: selectFavTeams.count == 0 ? [] : Array(selectedTeam))
            }catch{
                createAlertMessage()
            }
        }
    }
    
    
}
