//
//  StoryBoardExtension.swift
//  StateManagement
//
//  Created by AyeSuNaing on 12/11/2023.
//

import Foundation
import UIKit



enum StoryBoardName: String{
    case Main = "Main"
}



extension UIStoryboard{
    
    static func mainStoryBoard()-> UIStoryboard{
        UIStoryboard(name: "Main", bundle: nil)
    }
    
    
}

