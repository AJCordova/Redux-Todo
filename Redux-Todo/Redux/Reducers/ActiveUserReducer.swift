//
//  ActiveUserReducer.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/29/22.
//

import ReSwift

func activeUserReducer(action: Action, state: ActiveUserState?) -> ActiveUserState {
    var state = state ?? ActiveUserState()
    
    guard let action = action as? ActiveUserActions else { return state }
    
    switch action {
    case .getCurrentUser(let user):
        state.user = user
        
    case .getTasks(let tasks):
        state.user?.tasks = tasks
        
    case .add(let task):
        state.user?.tasks?.append(task)
        
    case .edit(let task):
        state.selectedTask = task
        
    case .delete(let index):
        state.user?.tasks?.remove(at: index)
    }
    
    return state
}
