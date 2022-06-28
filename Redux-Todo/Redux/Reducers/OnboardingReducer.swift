//
//  OnboardingReducer.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/28/22.
//

import ReSwift

func onboardingReducer(action: Action, state: OnboardNewUserState?) -> OnboardNewUserState {
    var state = state ?? OnboardNewUserState()
    
    switch action {
    case let action as OnboardNewUserAction:
        state.name = action.name
        
    default:
        break
    }
    
    return state
}

