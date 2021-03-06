//
//  AppRooter+Coordinator.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/30/22.
//

import Foundation

protocol TaskActionsDelegate: AnyObject {
    func createAction(action: TaskAction)
    func editAction(action: TaskAction, selectedTask: Task?)
}

// TODO: Use coordinators for app navigation instead.
extension AppRouter: TaskActionsDelegate {
    func createAction(action: TaskAction) {
        navigationController.present(TodoEditViewController(action: .add, task: nil), animated: true)
    }
    
    func editAction(action: TaskAction, selectedTask: Task?) {
        navigationController.present(TodoEditViewController(action: .edit, task: selectedTask), animated: true)
    }
}
