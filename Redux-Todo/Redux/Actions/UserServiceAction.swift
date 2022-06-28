//
//  UserServiceAction.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/26/22.
//

import ReSwift

struct UserServiceAction: Action {
    let userServiceAction: UserServices
}

enum UserServices {
    case checkForSavedUserFiles
    case createNewUser
}
