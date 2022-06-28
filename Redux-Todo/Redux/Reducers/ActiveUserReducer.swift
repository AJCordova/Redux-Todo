//
//  ActiveUserReducer.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/29/22.
//

import ReSwift

func activeUserReducer(action: Action, state: ActiveUserState?) -> ActiveUserState {
    var state = state ?? ActiveUserState()
    
    switch action {
    case let action as UpdateTasksAction:
        state.user?.tasks = action.tasks
        
    case let action as AddTaskAction:
        state.user?.tasks?.append(action.task)
        
    case let action as RemoveTaskAction:
        state.user?.tasks?.remove(at: action.index)
    
    case let action as LoadUserAction:
        state.user = action.user

    default:
        break
    }
    
    return state
}
