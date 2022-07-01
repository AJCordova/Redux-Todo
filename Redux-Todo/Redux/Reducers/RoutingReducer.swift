//
//  RoutingReducer.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/26/22.
//

import ReSwift

func routingReducer(action: Action, state: RoutingState?) -> RoutingState {
    var state = state ?? RoutingState()
    
    guard let action = action as? RoutingDestination else { return state }
    
    switch action {
    case .root:
        state.navigationState = .root
    case .newUser:
        state.navigationState = .newUser
    case .todo:
        state.navigationState = .todo
    }
    
    return state
}
