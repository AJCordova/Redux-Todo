//
//  UserServiceState.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/26/22.
//

import ReSwift

struct SavedUserFilesState: Equatable {
    var savedUserFilesState: UserServices
    
    init(hasSavedUserFiles: UserServices = .findSavedUserFiles) {
        self.savedUserFilesState = hasSavedUserFiles
    }
}
