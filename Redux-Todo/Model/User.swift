//
//  User.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/24/22.
//

import Foundation


struct User: Codable {
    
    var name: String?
    var tasks: [Task]?
    
    struct Task: Codable {
        var completed: Bool
        var title: String
        var details: String
    }
}

struct SampleData {
    static let testUserModel0: User = User(name: "Test",
                                                tasks: [User.Task(completed: false,
                                                                       title: "Jog",
                                                                       details: "10km"),
                                                        User.Task(completed: true,
                                                                       title: "Attend Meeting",
                                                                       details: "7am Meeting"),
                                                        User.Task(completed: false,
                                                                       title: "Make breakfast",
                                                                       details: "Bacon, eggs and toast.")])
    
    static let testUserModel1: User = User(name: "Test1",
                                                tasks: [User.Task(completed: false,
                                                                       title: "Jog",
                                                                       details: "10km"),
                                                        User.Task(completed: true,
                                                                       title: "Attend Meeting",
                                                                       details: "7am Meeting"),
                                                        User.Task(completed: false,
                                                                       title: "Make breakfast",
                                                                       details: "Bacon, eggs and toast.")])
}
