//
//  RoutingAction.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/26/22.
//

import ReSwift

struct RoutingAction: Action {
    let destination: RoutingDestination
}

enum RoutingDestination {
    case root
    case newUser
    case todo
    case editTodo
    case changeUser
}
