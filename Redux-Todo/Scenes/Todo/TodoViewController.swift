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

class TodoViewController: UIViewController {
    
    lazy var todoHeaderLabel: UILabel = UILabel()
    lazy var changeUserButton: UIButton = UIButton()
    lazy var addTodoButton: UIButton = UIButton()
    lazy var todoTableView: UITableView = UITableView()
    lazy var disposeBag = DisposeBag()
    
    // private var viewModel: TodoViewModelTypes
    private let todoTableCellID = "TodoTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .systemBackground
        
        setupViews()
        setupBindings()
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
        todoHeaderLabel.text = "User's TODOs"
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
        todoTableView.register(UINib.init(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: todoTableCellID)
        view.addSubview(todoTableView)
        
        todoTableView.snp.makeConstraints { make in
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
                self.navigationController?.present(TodoEditViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        changeUserButton.rx.tap
            .bind {
                self.navigationController?.present(UsersListViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
}

//    var encodedJson = ""
//    var testModel: UserModel?
//    @IBAction func jsonAction(_ sender: Any) {
//        do {
//            let data = try JSONEncoder().encode(SampleData.testUserModel)
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print(jsonString)
//                encodedJson = jsonString
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//
//    @IBAction func decodeJson(_ sender: Any) {
//        let encodedJson = Data(encodedJson.utf8)
//        do {
//            let decoded = try JSONDecoder().decode(UserModel.self, from: encodedJson)
//            testModel = decoded
//        } catch {
//            print(error.localizedDescription)
//        }
//
//        guard let testModelTasks = testModel?.tasks else { return }
//
//        for testModelTask in testModelTasks {
//            print(testModelTask.title)
//            print(testModelTask.details)
//        }
//    }
