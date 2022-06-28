//
//  URL+Extensions.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/29/22.
//

import Foundation

extension URL {
    var localizedName: String? { (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName }
    
    var hasHiddenExtension: Bool {
        get {
            (try? resourceValues(forKeys: [.hasHiddenExtensionKey]))?.hasHiddenExtension == true
        }
        set {
            var resourceValues = URLResourceValues()
            resourceValues.hasHiddenExtension = newValue
            try? setResourceValues(resourceValues)
        }
    }
}
