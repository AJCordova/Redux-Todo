//
//  UsersListViewController.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/29/22.
//

import Foundation
import UIKit

class UsersListViewController: UIViewController {
    
    lazy var userTable: UITableView = UITableView()
    lazy var titleLabel: UILabel = UILabel()
    lazy var cancelButton: UIButton = UIButton()
    lazy var addUserButton: UIButton = UIButton()
    
    let userTableCellID = "UserTableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupViews()
        setupBindings()
    }
}

extension UsersListViewController {
    func setupViews() {
        setupCancelButton()
        setupTitleLabel()
        setupUserList()
        setupAddUserButton()
    }
    
    func setupCancelButton() {
        cancelButton.setTitle("Cancel", for: .normal)
        view.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(20)
        }
    }
    
    func setupTitleLabel() {
        titleLabel.text = "Change User"
        titleLabel.font = .systemFont(ofSize: 20)
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.top.equalTo(cancelButton.snp.bottom).offset(30)
        }
    }
    
    func setupUserList() {
        userTable.register(UINib.init(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: userTableCellID)
        view.addSubview(userTable)

        userTable.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(500)
        }
    }
    
    func setupAddUserButton() {
        addUserButton.backgroundColor = .systemGreen
        addUserButton.setTitle("Add User", for: .normal)
        addUserButton.layer.cornerRadius = 9.0
        view.addSubview(addUserButton)
        
        addUserButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.left.right.equalToSuperview().inset(50)
        }
    }
}

extension UsersListViewController {
    func setupBindings() {
        cancelButton.rx.tap
            .bind(onNext: {
                self.dismiss(animated: true)
            })
    }
}
