//
//  UserModel.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/24/22.
//

import Foundation


struct UserModel: Codable {
    
    var username: String?
    var tasks: [Task]?
    
    struct Task: Codable {
        var completed: Bool
        var title: String
        var details: String
    }
}

struct SampleData {
    static let testUserModel0: UserModel = UserModel(username: "Test",
                                                tasks: [UserModel.Task(completed: false,
                                                                       title: "Jog",
                                                                       details: "10km"),
                                                        UserModel.Task(completed: true,
                                                                       title: "Attend Meeting",
                                                                       details: "7am Meeting"),
                                                        UserModel.Task(completed: false,
                                                                       title: "Make breakfast",
                                                                       details: "Bacon, eggs and toast.")])
    
    static let testUserModel1: UserModel = UserModel(username: "Test1",
                                                tasks: [UserModel.Task(completed: false,
                                                                       title: "Jog",
                                                                       details: "10km"),
                                                        UserModel.Task(completed: true,
                                                                       title: "Attend Meeting",
                                                                       details: "7am Meeting"),
                                                        UserModel.Task(completed: false,
                                                                       title: "Make breakfast",
                                                                       details: "Bacon, eggs and toast.")])
}
