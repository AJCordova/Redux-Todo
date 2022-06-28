//
//  FindSavedUserFilesAction.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/26/22.
//

import ReSwift

struct FindSavedUserFilesAction: Action {
    let userServiceAction: UserServices
}

enum UserServices {
    case findSavedUserFiles
}
