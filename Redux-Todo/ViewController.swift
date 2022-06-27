//
//  ViewController.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/24/22.
//

import UIKit
import ReSwift

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        
        store.subscribe(self) { subscription in
            subscription.select { state in
                state.userServiceState
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
}

extension ViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = UserServiceState
    
    func newState(state: UserServiceState) {
        let fileServices = UserFileServices()
        let hasSavedDirectory = fileServices.exists(file: fileServices.getURL(for: .TodoDirectory))
        
        switch state.hasSavedUserFiles {
        case .checkForSavedUserFiles:
            store.dispatch(
                hasSavedDirectory ? RoutingAction(destination: .todo) : RoutingAction(destination: .newUser)
            )
        }
    }
}
