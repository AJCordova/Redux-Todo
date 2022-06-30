//
//  TodoViewController+View.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/30/22.
//

import Foundation
import SnapKit

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
        tableView.register(UINib(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoTableViewCell")
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(todoHeaderLabel.snp.bottom).offset(50)
            make.width.equalToSuperview()
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
