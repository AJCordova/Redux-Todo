//
//  ActiveUserState.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/28/22.
//

import ReSwift

struct ActiveUserState {
    var activeUser: UserModel
    
    init(activeUser: UserModel = UserModel()) {
        self.activeUser = activeUser
    }
}
