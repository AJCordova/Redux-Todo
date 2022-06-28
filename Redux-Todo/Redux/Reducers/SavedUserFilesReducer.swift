//
//  SavedUserFilesReducer.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/26/22.
//

import ReSwift

func savedUserFilesReducer(action: Action, state: SavedUserFilesState?) -> SavedUserFilesState {
    var state = state ?? SavedUserFilesState()
    
    switch action {
    case let action as FindSavedUserFilesAction:
        state.savedUserFilesState = action.userServiceAction
        
    default:
        break
    }
    
    return state
}
