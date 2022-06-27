//
//  UserServiceState.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/26/22.
//

import ReSwift

struct UserServiceState: Equatable {
    var hasSavedUserFiles: UserServices
    
    init(hasSavedUserFiles: UserServices = .checkForSavedUserFiles) {
        self.hasSavedUserFiles = hasSavedUserFiles
    }
}
