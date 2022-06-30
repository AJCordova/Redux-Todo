//
//  TodoViewController.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/26/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import ReSwift

class TodoViewController: UIViewController {
    
    lazy var todoHeaderLabel: UILabel = UILabel()
    lazy var changeUserButton: UIButton = UIButton()
    lazy var addTodoButton: UIButton = UIButton()
    lazy var tableView: UITableView = UITableView()
    
    private let disposeBag = DisposeBag()
    private var data: PublishSubject<[Task]> = PublishSubject<[Task]>()
    private let userServices = UserFileServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .systemBackground
        
        setupViews()
        setupBindings()
        
        store.subscribe(self) { subscription in
            subscription.select({ select in
                select.activeUserState
            })
        }
    }
}

extension TodoViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = ActiveUserState
    
    func newState(state: ActiveUserState) {
        let fileService = UserFileServices()
        
        if state.user == nil {
            fileService.loadFirstUser()
        } else {
            if let user = state.user {
                if let name = user.name {
                    todoHeaderLabel.text = "\(name)'s TODOs"
                }
                
                if let tasks = user.tasks {
                    data.onNext(tasks)
                }
            }
        }
    }
}
// MARK: Bindings set-up
extension TodoViewController {
    func setupBindings() {
        addTodoButton.rx.tap
            .bind {
                
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Task.self)
            .subscribe(onNext: { task in
                
            })
            .disposed(by: disposeBag)
        
        changeUserButton.rx.tap
            .bind {
                DispatchQueue.main.async {
                    store.dispatch(RoutingDestination.changeUser)
                }
            }
            .disposed(by: disposeBag)
        
        data.asObservable()
            .bind(to: tableView.rx.items) { (tableView, row, task) -> UITableViewCell in
                let cell: TodoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell") as! TodoTableViewCell
                cell.title.text = task.title
                return cell
            }
            .disposed(by: disposeBag)
    }
}
