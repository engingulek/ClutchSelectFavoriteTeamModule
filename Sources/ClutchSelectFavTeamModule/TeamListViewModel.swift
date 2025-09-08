//
//  Untitled.swift
//  ClutchSelectFavTeamModule
//
//  Created by Engin Gülek on 7.09.2025.
//
import Foundation



protocol TeamListViewModelProtocol : ObservableObject {
    var selectedTeam : Set<String> {get}
    var teamList : [Team] {get}
    var selectCount : Int {get}
    var selectedCountText:String {get}
    var textState:TextState {get}
    var countiuneButton : (disableState:Bool,backColor:CountiuneButtonBackColor) {get}
    func onTappedTeamIcon(id:String)
    func teamBorderColor(id:String) -> BorderColor
}


class TeamListViewModel : TeamListViewModelProtocol {
   @Published var countiuneButton: (disableState: Bool, backColor: CountiuneButtonBackColor)
    = (disableState:true,backColor:CountiuneButtonBackColor.disable)
    var selectedTeam: Set<String> = []
    var textState: TextState = TextState()
    var selectedCountText: String = "0/2"
    
    //MARK: default list
    var teamList: [Team] = [
        Team(image: "https://upload.wikimedia.org/wikipedia/tr/2/2e/Liverpool_FC_logo_2024.png"),
        Team(image: "https://upload.wikimedia.org/wikipedia/tr/thumb/9/92/Arsenal_Football_Club.png/330px-Arsenal_Football_Club.png"),
        Team(image: "https://upload.wikimedia.org/wikipedia/tr/thumb/f/f6/Manchester_City.png/300px-Manchester_City.png"),
        Team(image: "https://upload.wikimedia.org/wikipedia/tr/6/6d/Tottenham_Hotspur.png")
        
        
    ]
    
    
  @Published  var selectCount: Int = 0
    
    
    func onTappedTeamIcon(id: String) {
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
    
    
    func teamBorderColor(id: String) -> BorderColor {
        return selectedTeam.contains(id)
        ? BorderColor.selected
        : BorderColor.notSelected
    }
    
    
}
