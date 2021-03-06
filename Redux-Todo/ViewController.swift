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
                state.savedUserFilesState
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
}

extension ViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = SavedUserFilesState
    
    func newState(state: SavedUserFilesState) {
        let fileServices = UserFileServices()
        let hasSavedDirectory = fileServices.exists(file: fileServices.getURL(for: .TodoDirectory))
        
        switch state.savedUserFilesState {
        case .findSavedUserFiles:
            DispatchQueue.main.async {
                store.dispatch(
                    hasSavedDirectory ? RoutingDestination.todo : RoutingDestination.newUser
                )
            }
        }
    }
}
