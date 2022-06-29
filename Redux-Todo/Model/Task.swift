//
//  Task.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/29/22.
//

import Foundation

struct Task: Codable, Equatable {
    var completed: Bool
    var title: String
    var details: String
}
