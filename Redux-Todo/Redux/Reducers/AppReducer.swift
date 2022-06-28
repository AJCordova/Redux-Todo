//
//  AppReducer.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/26/22.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        routingState: routingReducer(action: action, state: state?.routingState),
        userServiceState: userServiceReducer(action: action, state: state?.userServiceState),
        activeUserState: activeUserReducer(action: action, state: state?.activeUserState)
    )
}
