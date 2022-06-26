//
//  TodoViewController.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/26/22.
//

import Foundation
import UIKit

class TodoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
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
