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
    func deleteAction(action: TaskAction, selectedTask: Task?)
}

// TODO: Use coordinators for app navigation instead.
extension AppRouter: TaskActionsDelegate {
    func createAction(action: TaskAction) {
        navigationController.present(TodoEditViewController(action: .create, task: nil), animated: true)
    }
    
    func editAction(action: TaskAction, selectedTask: Task?) {
        navigationController.present(TodoEditViewController(action: .create, task: selectedTask), animated: true)
    }
    
    func deleteAction(action: TaskAction, selectedTask: Task?) {
        navigationController.present(TodoEditViewController(action: .delete, task: selectedTask), animated: true)
    }
}
