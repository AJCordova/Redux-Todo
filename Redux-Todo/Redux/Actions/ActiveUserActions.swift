//
//  ActiveUserActions.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/29/22.
//

import ReSwift

struct LoadUserAction: Action {
    let user: User
}

struct UpdateTasksAction: Action {
    let tasks: [Task]
}

struct AddTaskAction: Action {
    let task: Task
}

struct RemoveTaskAction: Action {
    let index: Int
}
