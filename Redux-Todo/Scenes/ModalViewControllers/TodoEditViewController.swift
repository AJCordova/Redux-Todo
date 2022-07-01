//
//  TodoEditViewController.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/29/22.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import ReSwift

class TodoEditViewController: UIViewController {
    lazy var cancelButton: UIButton = UIButton(type: .system) as UIButton
    lazy var saveButton: UIButton = UIButton()
    lazy var titleLabel: UILabel = UILabel()
    lazy var titleTextField: UITextField = UITextField()
    lazy var detailLabel: UILabel = UILabel()
    lazy var detailTextField: UITextView = UITextView()
    lazy var completeButton: UIButton = UIButton()
    lazy var deleteButton: UIButton = UIButton(type: .system) as UIButton
    private let disposeBag = DisposeBag()
    
    var action: TaskAction = .add
    var task: Task?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(action: TaskAction, task: Task?) {
        self.init(nibName: nil, bundle: nil)
        self.action = action
        self.task = task
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        store.subscribe(self) { subscription in
            subscription.select({ select in
                select.activeUserState
            })
        }
        
        setupViews()
        setupBindings()
        setTask(task: task)
    }
    
    private func setTask(task: Task?) {
        guard let task = task else { return }
        titleTextField.text = task.title
        detailTextField.text = task.details
    }
}

extension TodoEditViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = ActiveUserState
    
    func newState(state: ActiveUserState) {
        guard let user = state.user else { return }
        let fileService = UserFileServices()
        fileService.saveToJSON(user: user)
        
        self.dismiss(animated: true)
    }
}

extension TodoEditViewController {
    func setupViews() {
        setupCancelButton()
        setupSaveButton()
        setupTitleLabel()
        setupTitleTextField()
        setupDetailLabel()
        setupDetailTextField()
        setupCompleteButton()
        setupDeleteButton()
    }
    
    func setupCancelButton() {
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.tintColor = .systemRed
        view.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(20)
        }
    }
    
    func setupDeleteButton() {
        deleteButton.setTitle("DELETE", for: .normal)
        deleteButton.tintColor = .systemRed
        deleteButton.isHidden = action == .add ? true : false
        view.addSubview(deleteButton)
        
        deleteButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(20)
        }
    }
    
    func setupTitleLabel() {
        titleLabel.text = "Title: "
        titleLabel.font = .systemFont(ofSize: 20)
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.top.equalTo(cancelButton.snp.bottom).offset(50)
        }
    }
    
    func setupTitleTextField() {
        titleTextField.layer.borderColor = UIColor.systemGray3.cgColor
        titleTextField.layer.borderWidth = 0.5
        titleTextField.autocapitalizationType = .none
        titleTextField.autocorrectionType = .no
        view.addSubview(titleTextField)
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(25)
            make.height.equalTo(30)
        }
    }
    
    func setupDetailLabel() {
        detailLabel.text = "Detail: "
        detailLabel.font = .systemFont(ofSize: 20)
        view.addSubview(detailLabel)
        
        detailLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
        }
    }
    
    func setupDetailTextField() {
        detailTextField.layer.borderColor = UIColor.systemGray3.cgColor
        detailTextField.layer.borderWidth = 0.5
        detailTextField.autocapitalizationType = .none
        detailTextField.autocorrectionType = .no
        
        view.addSubview(detailTextField)
        
        detailTextField.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(25)
            make.height.equalTo(350)
        }
    }
    
    func setupCompleteButton() {
        completeButton.setTitle(task?.completed == true ? "Undo Task" : "Complete Task", for: .normal)
        completeButton.setTitleColor(.systemBlue, for: .normal)
        completeButton.isHidden = action == .add
        view.addSubview(completeButton)
        
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(detailTextField.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(50)
        }
    }
    
    func setupSaveButton() {
        saveButton.backgroundColor = .systemGreen
        saveButton.setTitle("Save Button", for: .normal)
        saveButton.layer.cornerRadius = 9.0
        view.addSubview(saveButton)
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.left.right.equalToSuperview().inset(50)
        }
    }
}

extension TodoEditViewController {
    func setupBindings() {
        let shouldShowSaveButton = self.titleTextField.rx.text.orEmpty
            .map { $0.count < 3 }
            .asObservable()
        
        shouldShowSaveButton.asObservable()
            .bind(to: saveButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        saveButton.rx.tap
            .bind {
                guard let title = self.titleTextField.text else { return }

                switch self.action {
                case .add:
                    store.dispatch(ActiveUserActions.add(task: Task(completed: false,
                                                                    title: title,
                                                                    details: self.detailTextField.text ?? "" )))
                case .edit:
                    guard var task = self.task else { return }
                    task.title = title
                    task.details = self.detailTextField.text ?? ""
                    store.dispatch(ActiveUserActions.edit(task: task))
                    
                case .delete:
                    break
                }
            }
            .disposed(by: disposeBag)
        
        completeButton.rx.tap
            .bind {
                guard var task = self.task else { return }
                task.completed.toggle()
                
                guard let title = self.titleTextField.text else { return }
                task.title = title
                task.details = self.detailTextField.text ?? ""
                store.dispatch(ActiveUserActions.edit(task: task))
            }
            .disposed(by: disposeBag)
        
        deleteButton.rx.tap
            .bind {
                guard let task = self.task else { return }
                store.dispatch(ActiveUserActions.delete(task: task))
            }
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .bind {
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
