//
//  ActiveUserAction.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/28/22.
//

import ReSwift

struct ActiveUserAction: Action {
    let userAction: ActiveUserActions
}

enum ActiveUserActions {
    case createNewUser
    case createNewTask
    case editNewTask
    case deleteTask
}
