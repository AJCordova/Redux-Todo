//
//  OnboardUserViewController.swift
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

class OnboardUserViewController: UIViewController {
    
    lazy var greetingBannerLabel: UILabel = UILabel()
    lazy var usernameTextField: UITextField = UITextField()
    lazy var createNewUser: UIButton = UIButton()
    lazy var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .systemBackground
        
        setupViews()
        setupBindings()
        
        store.subscribe(self) { subscription in
            subscription.select({ select in
                select.onboardNewUserState
            })
        }
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
}

// MARK: New state changes
extension OnboardUserViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = OnboardNewUserState
    
    func newState(state: OnboardNewUserState) {
        if !state.name.isEmpty {
            DispatchQueue.main.async {
                store.dispatch(
                    RoutingAction(destination: .todo)
                )
            }
        }
    }
}

// MARK: view set-up
extension OnboardUserViewController {
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
        
        createNewUser.setImage(continueButtonImage, for: .normal)
        createNewUser.tintColor = .systemGreen
        createNewUser.isHidden = false
        view.addSubview(createNewUser)
        
        createNewUser.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.equalToSuperview()
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
        }
    }
}

// MARK: Set-up bindings
extension OnboardUserViewController {
    private func setupBindings() {
        usernameTextField.rx.text.orEmpty.distinctUntilChanged()
            .map { $0.isEmpty ? true : false  }
            .bind(to: self.createNewUser.rx.isHidden)
            .disposed(by: disposeBag)
        
        createNewUser.rx.tap
            .bind {
                guard let username = self.usernameTextField.text else { return }
                self.createNewUserFile(username: username)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: Functionality
extension OnboardUserViewController {
    
    private func createNewUserFile(username: String) {
        let fileServices = UserFileServices()
        let hasSavedDirectory = fileServices.exists(file: fileServices.getURL(for: .TodoDirectory))
        
        if !hasSavedDirectory {
            fileServices.createTodoDirectory()
        }
        
        if fileServices.doesUserFileExist(name: username) {
            return
        }
        
        do {
            // TODO: Move to user services
            let data = try JSONEncoder().encode(User(name: username, tasks: []))
            if let jsonString = String(data: data, encoding: .utf8) {
                if fileServices.saveToJSON(containing: jsonString, to: .TodoDirectory, withName: username + ".json") {
                    store.dispatch(OnboardNewUserAction(name: username))
                }
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
}

