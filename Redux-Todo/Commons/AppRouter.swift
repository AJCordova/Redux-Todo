//
//  AppRouter.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/26/22.
//

import ReSwift

final class AppRouter {
    let navigationController: UINavigationController
    
    init(window: UIWindow) {
        navigationController = UINavigationController()
        window.rootViewController = navigationController
        
        store.subscribe(self) { subscription in
            subscription.select { state in
                state.routingState
            }
        }
    }
    
    fileprivate func push(viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    fileprivate func present(viewController: UIViewController, animated: Bool) {
        navigationController.present(viewController, animated: animated)
    }
}

extension AppRouter: StoreSubscriber {
    typealias StoreSubscriberStateType = RoutingState
    
    func newState(state: RoutingState) {
        switch state.navigationState {
        case .newUser:
            push(viewController: OnboardUserViewController(), animated: true)
        case .todo:
            push(viewController: TodoViewController(), animated: true)
        case .root:
            push(viewController: ViewController(), animated: true)
        case .editTodo(let mode, let task):
            present(viewController: TodoEditViewController(with: mode, task: task), animated: true)
        case .changeUser:
            present(viewController: UsersListViewController(), animated: true)
        }
    }
}
