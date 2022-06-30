//
//  Constants.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/26/22.
//

import Foundation

enum AppDirectories: String {
    case Documents = "Documents"
    case TodoDirectory = "TODO"
}

enum TaskAction {
    case create, edit, delete
}
