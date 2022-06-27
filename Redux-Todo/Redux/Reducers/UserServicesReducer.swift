//
//  UserServicesReducer.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/26/22.
//

import ReSwift

func userServiceReducer(action: Action, state: UserServiceState?) -> UserServiceState {
    var state = state ?? UserServiceState()
    
    switch action {
    case let action as UserServiceAction:
        state.hasSavedUserFiles = action.userServiceAction
    default:
        break
    }
    
    return state
}
