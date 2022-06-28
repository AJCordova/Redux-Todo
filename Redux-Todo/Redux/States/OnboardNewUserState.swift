//
//  OnboardNewUserState.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/28/22.
//

import ReSwift

struct OnboardNewUserState: Equatable {
    var name: String
    
    init(name: String = String()) {
        self.name = name
    }
}
