//
//  RoutingState.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/26/22.
//

import ReSwift

struct RoutingState {
    var navigationState: RoutingDestination
    
    init(navigationState: RoutingDestination = .root) {
        self.navigationState = navigationState
    }
    
}
