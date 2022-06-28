//
//  NewUserViewController.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/26/22.
//

import Foundation
import UIKit
import SnapKit
import ReSwift
import RxSwift
import RxCocoa

class NewUserViewController: UIViewController {
    
    lazy var greetingBannerLabel: UILabel = UILabel()
    lazy var usernameTextField: UITextField = UITextField()
    lazy var continueButton: UIButton = UIButton()
    lazy var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .systemBackground
        
        setupViews()
        setupBindings()
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

// MARK: view set-up
extension NewUserViewController {
    private func setupViews() {
        setupGreetingBanner()
        setupUsernameTextField()
        setupContinueButton()
    }
    
    private func setupGreetingBanner() {
        greetingBannerLabel.text = "Hello,"
        greetingBannerLabel.font = .boldSystemFont(ofSize: 30)
        greetingBannerLabel.textAlignment = .center
        view.addSubview(greetingBannerLabel)
        
        greetingBannerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
        }
    }
    
    private func setupUsernameTextField() {
        usernameTextField.placeholder = "Tell us your name"
        usernameTextField.textAlignment = .center
        usernameTextField.autocorrectionType = .no
        usernameTextField.autocapitalizationType = .none
        usernameTextField.font = .boldSystemFont(ofSize: 30)
        view.addSubview(usernameTextField)
        
        usernameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-50)
            make.top.equalTo(greetingBannerLabel.snp.bottom).offset(30)
        }
    }
    
    private func setupContinueButton() {
        let imageConfig = UIImage.SymbolConfiguration(font: .boldSystemFont(ofSize: 30),
                                                      scale: .medium)
        
        let continueButtonImage = UIImage(systemName: "arrow.right",
                                            withConfiguration: imageConfig)
        
        continueButton.setImage(continueButtonImage, for: .normal)
        continueButton.tintColor = .systemGreen
        continueButton.isEnabled = false
        view.addSubview(continueButton)
        
        continueButton.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.equalToSuperview()
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
        }
    }
}

extension NewUserViewController {
    private func setupBindings() {
        usernameTextField.rx.text.orEmpty.distinctUntilChanged()
            .map { !$0.isEmpty ? true : false  }
            .bind(to: self.continueButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        continueButton.rx.tap.bind {
            
        }
    }
}

