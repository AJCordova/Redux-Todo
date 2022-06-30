//
//  AppState.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/26/22.
//

import ReSwift

struct AppState {
    var routingState: RoutingState = RoutingState()
    var savedUserFilesState: SavedUserFilesState = SavedUserFilesState()
    var onboardNewUserState: OnboardNewUserState = OnboardNewUserState()
    var activeUserState: ActiveUserState = ActiveUserState()
}
