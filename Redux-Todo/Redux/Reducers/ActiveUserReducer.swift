//
//  ActiveUserReducer.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/28/22.
//

import ReSwift

func activeUserReducer(action: Action, state: ActiveUserState?) -> ActiveUserState {
    var state = state ?? ActiveUserState()
    
    switch action {
    case let action as ActiveUserAction:
        
    default:
        break
    }
    
    return state
}
