//
//  UserFileServicesProtocol.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/27/22.
//

import Foundation

protocol UserFileServicesProtocol {
    func documentsDirectoryURL() -> URL
    
    func todoDirectoryURL() -> URL
    
    func getURL(for directory: AppDirectories) -> URL
    
    func createTodoDirectory()
    
    func exists(file at: URL) -> Bool
    
    func doesUserFileExist(name: String) -> Bool
    
    func saveToJSON(containing: String, to path: AppDirectories, withName name: String) -> Bool
    
    func readFromJSON(file at: URL) -> String
    
    func loadFirstUser()
}
