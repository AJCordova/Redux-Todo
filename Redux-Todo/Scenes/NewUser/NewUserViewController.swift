//
//  NewUserViewController.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/26/22.
//

import Foundation
import UIKit
import SnapKit

class NewUserViewController: UIViewController {
    
    lazy var greetingBannerLabel: UILabel = UILabel()
    lazy var usernameTextField: UITextField = UITextField()
    lazy var continueButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .systemBackground
        
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0,
                                  y: usernameTextField.frame.height - 1,
                                  width: usernameTextField.frame.width,
                                  height: 1.0)
        bottomLine.backgroundColor = UIColor.systemGreen.cgColor
        usernameTextField.borderStyle = .none
        usernameTextField.layer.addSublayer(bottomLine)
    }
}

extension NewUserViewController {
    func setupViews() {
        setupGreetingBanner()
        setupUsernameTextField()
        setupContinueButton()
    }
    
    func setupGreetingBanner() {
        greetingBannerLabel.text = "Hello,"
        greetingBannerLabel.font = .boldSystemFont(ofSize: 30)
        greetingBannerLabel.textAlignment = .center
        view.addSubview(greetingBannerLabel)
        
        greetingBannerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
        }
    }
    
    func setupUsernameTextField() {
        usernameTextField.placeholder = "What is your name?"
        usernameTextField.textAlignment = .center
        usernameTextField.autocorrectionType = .no
        usernameTextField.autocapitalizationType = .none
        usernameTextField.font = .boldSystemFont(ofSize: 20)
        view.addSubview(usernameTextField)
        
        usernameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(greetingBannerLabel.snp.bottom).offset(50)
        }
    }
    
    func setupContinueButton() {
        continueButton.setImage(UIImage(systemName: "arrow.right"),
                                for: .normal)
        continueButton.tintColor = .systemGreen
        continueButton.isEnabled = false
        view.addSubview(continueButton)
        
        continueButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(30)
            make.leading.equalTo(usernameTextField.snp.trailing).offset(20)
            make.top.equalTo(greetingBannerLabel.snp.bottom).offset(50)
        }
    }
    
}

