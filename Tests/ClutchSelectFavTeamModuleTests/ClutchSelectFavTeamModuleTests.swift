


import Testing
@testable import ClutchSelectFavTeamModule
import ClutchCoreKit

@Suite("Test For Select Fav Template ")
class ClutchSelectFavTeamModuleTests {
    var viewModel : (any TeamListViewModelProtocol)!
    
    init() {
        self.viewModel = TeamListViewModel()
    }
    
    @Test("Favorite Team Selection Page title and subtitle verification")
    func testTitleAndSubTitleCheck(){
        let expectedTitle = LocalizableTheme.selectFavTeamTitle.localized
        let expectedSubTitle = LocalizableTheme.selectFavTeamSubTitle.localized
        
        
        #expect(expectedTitle == viewModel.textState.title)
        #expect(expectedSubTitle == viewModel.textState.subTitle)
        
    }
    
    
    @Test("Favorite Team Selection Page initial selectedCount should be 0")
    func testInitialSelectedCountIsZero() {
        let expectedCount = 0
        
        #expect(expectedCount == viewModel.selectCount)
    }
    
    @Test("SelectedCount should increment when a team is selected")
    func testSelectedCountIncrements() {
        let expectedSelectedCountText = "1/2"
        
        let testID = "testId"
        
        viewModel.onTappedTeamIcon(id: testID)
        
        #expect(expectedSelectedCountText == viewModel.selectedCountText)
        
        
    }
    
    
    @Test("SelectedCount should decrease when a team is selected")
    func testSelectedCountDecrease() {
        let expectedSelectedCountText = "0/2"
        
        let testID = "testId"
        // add
        viewModel.onTappedTeamIcon(id: testID)
        //remove
        viewModel.onTappedTeamIcon(id: testID)
        
        #expect(expectedSelectedCountText == viewModel.selectedCountText)
        
        
    }
    
    @Test("Selected teams should have border ")
    func testSelectedTeamBorder() {
        let expectedSelectedTeamBorder : BorderColor = .selected
        let testID = "testId"
        viewModel.onTappedTeamIcon(id: testID)
        let border = viewModel.teamBorderColor(id: testID)
        #expect(expectedSelectedTeamBorder == border)
    }
    
    
    @Test("Continue button should be disabled initially")
    func testContinueButtonInitiallyDisabled() {
        let expectedCountiuneButton : (disableState:Bool,backColor:CountiuneButtonBackColor)
        = (disableState:true,backColor:CountiuneButtonBackColor.disable)
        
        let button = viewModel.countiuneButton
        
        #expect(button.disableState == expectedCountiuneButton.disableState)
        #expect(button.backColor == expectedCountiuneButton.backColor)
    }
    
    @Test("Continue button should be enabled only when selectedCount is 2")
    func testContinueButtonEnablesOnSingleSelection() {
        let expectedCountiuneButton : (disableState:Bool,backColor:CountiuneButtonBackColor)
        = (disableState:false,backColor:CountiuneButtonBackColor.able)
        let testID = "testId"
        let testId1 = "testid 1"
        
        viewModel.onTappedTeamIcon(id: testID)
        viewModel.onTappedTeamIcon(id: testId1)
        let button = viewModel.countiuneButton
        
        #expect(button.disableState == expectedCountiuneButton.disableState)
        #expect(button.backColor == expectedCountiuneButton.backColor)
        
        
    }
    
    
    
        
    
}
