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

class TodoEditViewController: UIViewController {
    
    lazy var cancelButton: UIButton = UIButton(type: .system) as UIButton
    lazy var saveButton: UIButton = UIButton()
    lazy var titleLabel: UILabel = UILabel()
    lazy var titleTextField: UITextField = UITextField()
    lazy var detailLabel: UILabel = UILabel()
    lazy var detailTextField: UITextView = UITextView()
    lazy var deleteButton: UIButton = UIButton(type: .system) as UIButton
    
    private let disposeBag = DisposeBag()
    
    let mode: EditMode
    var task: Task?
    
    init(with mode: EditMode, task: Task?) {
        self.mode = mode
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
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

extension TodoEditViewController {
    func setupViews() {
        setupCancelButton()
        setupSaveButton()
        setupTitleLabel()
        setupTitleTextField()
        setupDetailLabel()
        setupDetailTextField()
        setupDeleteButton()
    }
    
    func setupCancelButton() {
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.tintColor = .systemBlue
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
        deleteButton.tintColor = .systemBlue
        
        if mode == .create {
            deleteButton.isHidden = true
        }
        
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

// MARK: Bindings
extension TodoEditViewController {
    
    func setupBindings() {
        cancelButton.rx.tap.bind(onNext: {
                self.dismiss(animated: true)
        })
        .disposed(by: disposeBag)
        
        saveButton.rx.tap.bind(onNext: { [self] in
            mode == .create ? self.createTask() : self.editTask()
        })
        .disposed(by: disposeBag)
    }
}

extension TodoEditViewController {
    private func createTask() {
        guard let title = titleTextField.text else { return }
        store.dispatch(ActiveUserActions.add(task: Task(completed: false, title: title, details: detailTextField.text ?? "" )))
    }
    
    private func editTask() {
        guard var task = task, let title = titleTextField.text else { return }
        task.title = title
        task.details = detailTextField.text ?? ""
        store.dispatch(ActiveUserActions.edit(task: task))
    }
}
