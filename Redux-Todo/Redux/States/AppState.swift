//
//  AppState.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/26/22.
//

import ReSwift

struct AppState {
    let routingState: RoutingState
    let savedUserFilesState: SavedUserFilesState
    let onboardNewUserState: OnboardNewUserState
    let activeUserState: ActiveUserState
}
