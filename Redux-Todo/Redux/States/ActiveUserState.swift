//
//  ActiveUserState.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/29/22.
//

import ReSwift

struct ActiveUserState {
    var user: User?
    var tasks: [Task] = []
    var selectedTask: Task?
}
