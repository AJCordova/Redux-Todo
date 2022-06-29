//
//  User.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/24/22.
//

import Foundation


struct User: Codable, Equatable {
    
    var name: String?
    var tasks: [Task]?
}

struct SampleData {
    static let testUserModel0: User = User(name: "Test",
                                                tasks: [Task(completed: false,
                                                                       title: "Jog",
                                                                       details: "10km"),
                                                        Task(completed: true,
                                                                       title: "Attend Meeting",
                                                                       details: "7am Meeting"),
                                                        Task(completed: false,
                                                                       title: "Make breakfast",
                                                                       details: "Bacon, eggs and toast.")])
    
    static let testUserModel1: User = User(name: "Test1",
                                                tasks: [Task(completed: false,
                                                                       title: "Jog",
                                                                       details: "10km"),
                                                        Task(completed: true,
                                                                       title: "Attend Meeting",
                                                                       details: "7am Meeting"),
                                                        Task(completed: false,
                                                                       title: "Make breakfast",
                                                                       details: "Bacon, eggs and toast.")])
}
