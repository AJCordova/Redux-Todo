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
    lazy var disposeBag = DisposeBag()
    
    private let todoTableCellID = "TodoTableViewCell"
    private var data: PublishSubject<[User.Task]> = PublishSubject<[User.Task]>()
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

// MARK: Views set-up
extension TodoViewController {
    func setupViews() {
        setupTodoHeaderLabel()
        setupChangeUserButton()
        setupAddTodoButton()
        setupTodoTableView()
    }
    
    func setupTodoHeaderLabel() {
        todoHeaderLabel.font = .systemFont(ofSize: 20, weight: .bold)
        view.addSubview(todoHeaderLabel)
        
        todoHeaderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
    }
    
    func setupChangeUserButton() {
        let imageConfig = UIImage.SymbolConfiguration(font: .boldSystemFont(ofSize: 30),
                                                      scale: .medium)
        let changeUserButtonImage = UIImage(systemName: "person.crop.circle",
                                            withConfiguration: imageConfig)
        changeUserButton.setImage(changeUserButtonImage, for: .normal)
        changeUserButton.tintColor = .systemGreen
        changeUserButton.isEnabled = true
        view.addSubview(changeUserButton)
        
        changeUserButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(30)
            make.top.equalToSuperview().offset(75)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func setupTodoTableView() {
        tableView.register(UINib.init(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: todoTableCellID)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(todoHeaderLabel.snp.bottom).offset(50)
            make.left.right.equalToSuperview().offset(20)
            make.height.equalTo(540)
        }
    }
    
    func setupAddTodoButton() {
        addTodoButton.backgroundColor = .systemGreen
        addTodoButton.setTitle("Add Todo", for: .normal)
        addTodoButton.layer.cornerRadius = 9.0
        view.addSubview(addTodoButton)
        
        addTodoButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.left.right.equalToSuperview().inset(50)
        }
    }
}

extension TodoViewController: UITableViewDelegate {
    
}

// MARK: Bindings set-up
extension TodoViewController {
    func setupBindings() {
        addTodoButton.rx.tap
            .bind {
                DispatchQueue.main.async {
                    store.dispatch(
                        RoutingAction(destination: .editTodo)
                    )
                }
            }
            .disposed(by: disposeBag)
        
        changeUserButton.rx.tap
            .bind {
                DispatchQueue.main.async {
                    store.dispatch(
                        RoutingAction(destination: .changeUser)
                    )
                }
            }
            .disposed(by: disposeBag)
        
        data
            .bind(to: tableView.rx.items) { [self](tableView, row, task) -> TodoTableViewCell in
                let cell = tableView.dequeueReusableCell(withIdentifier: self.todoTableCellID,
                                                        for: IndexPath.init(row: row, section: 0)) as! TodoTableViewCell
                
                cell.title.text = task.title
                return cell
            }
            .disposed(by: disposeBag)
    }
}
