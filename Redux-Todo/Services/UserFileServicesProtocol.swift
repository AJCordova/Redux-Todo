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
}

extension UserFileServicesProtocol {
    func exists(file at: URL) -> Bool {
        if FileManager.default.fileExists(atPath: at.path) {
            return true
        } else {
            return false
        }
    }
    
    func documentsDirectoryURL() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func todoDirectoryURL() -> URL {
        let folderName = AppDirectories.TodoDirectory.rawValue
        let documentsFolder = getURL(for: .Documents)
        
        return documentsFolder.appendingPathComponent(folderName)
    }
    
    func getURL(for directory: AppDirectories) -> URL {
        switch directory {
        case .Documents:
            return documentsDirectoryURL()
        case .TodoDirectory:
            return todoDirectoryURL()
        }
    }
        
    func createTodoDirectory() {
        let folderName = AppDirectories.TodoDirectory.rawValue
        let documentsFolder = getURL(for: .Documents)
        let folderURL = documentsFolder.appendingPathComponent(folderName)
        
        if !exists(file: folderURL) {
            do {
                try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: false)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func doesUserFileExist(name: String) -> Bool {
        let todoFolderURL = getURL(for: .TodoDirectory)
        var fileURLs: [URL]
        var savedUsers: [String]
        
        do {
            fileURLs = try FileManager.default.contentsOfDirectory(at: todoFolderURL,
                                                                   includingPropertiesForKeys: nil)
            
        } catch {
            print(error.localizedDescription)
            fileURLs = []
        }
        
        if fileURLs.isEmpty {
            return false
        } else {
            for var url in fileURLs {
                url.hasHiddenExtension = true
            }
            
            savedUsers = fileURLs.map {
                $0.localizedName ?? $0.lastPathComponent
            }
            
            if savedUsers.contains(name) {
                return true
            } else {
                return false
            }
        }
    }
}
