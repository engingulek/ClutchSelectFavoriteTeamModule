//
//  TeamModel.swift
//  ClutchSelectFavTeamModule
//
//  Created by Engin Gülek on 7.09.2025.
//
import SwiftUI
import ClutchCoreKit
import Foundation
struct Team:Hashable {
    let id = UUID()
    let image:String
    
}


enum BorderColor {
    case selected
    case notSelected

    var value: Color {
        switch self {
        case .selected:
            return .red
        case .notSelected:
            return .gray
        }
    }
}



enum CountiuneButtonBackColor {
    case able
    case disable

    var value: Color {
        switch self {
        case .able:
            return .black
        case .disable:
            return .gray
        }
    }
}


struct TextState {
    let title:String = LocalizableTheme.selectFavTeamTitle.localized
    let subTitle:String = LocalizableTheme.selectFavTeamSubTitle.localized
    let countiuneButton:String = LocalizableTheme.countiune.localized
}
