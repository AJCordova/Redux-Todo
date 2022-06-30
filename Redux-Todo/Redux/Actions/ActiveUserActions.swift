//
//  ActiveUserActions.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/29/22.
//

import ReSwift

enum ActiveUserActions: Action {
    case getCurrentUser(user: User)
    case getTasks(tasks: [Task])
    case add(task: Task)
    case edit(task: Task)
    case delete(task: Task)
}
