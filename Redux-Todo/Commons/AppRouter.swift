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
    
    fileprivate func pushViewController(viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    fileprivate func presentViewController(viewController: UIViewController, animated: Bool) {
        navigationController.present(viewController, animated: animated)
    }
}

extension AppRouter: StoreSubscriber {
    typealias StoreSubscriberStateType = RoutingState
    
    func newState(state: RoutingState) {
        switch state.navigationState {
        case .newUser:
            pushViewController(viewController: OnboardUserViewController(), animated: true)
        case .todo:
            pushViewController(viewController: TodoViewController(), animated: true)
        case .root:
            pushViewController(viewController: ViewController(), animated: true)
        }
    }
}
