//
//  UserFileServices.swift
//  Redux-Todo
//
//  Created by COLLABERA on 6/27/22.
//

import Foundation

struct UserFileServices : UserFileServicesProtocol {
    
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
    
    func saveToJSON(containing: String, to path: AppDirectories, withName name: String) -> Bool {
        let filePath = getURL(for: path).path + "/" + name
        let data: Data? = containing.data(using: .utf8)
        return FileManager.default.createFile(atPath: filePath, contents: data, attributes: nil)
    }
    
    func saveToJSON(user: User) {
        do {
            let data = try JSONEncoder().encode(user)
            if let jsonString = String(data: data, encoding: .utf8) {
                if saveToJSON(containing: jsonString, to: .TodoDirectory, withName: user.name! + ".json") {
                    store.dispatch(OnboardNewUserAction(name: user.name!))
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadFirstUser(){
        let todoFolderURL = getURL(for: .TodoDirectory)
        var user: User = User()
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: todoFolderURL,
                                                                       includingPropertiesForKeys: nil)
            
            if !fileURLs.isEmpty {
                let encodedJSON = readFromJSON(file: fileURLs[0])
                user = try JSONDecoder().decode(User.self, from: Data(encodedJSON.utf8))
                
                DispatchQueue.main.async {
                    store.dispatch(
                        ActiveUserActions.getCurrentUser(user: user)
                    )
                }
            } else {
                DispatchQueue.main.async {
                    store.dispatch(
                        ActiveUserActions.getCurrentUser(user: SampleData.testUserModel1)
                    )
                }
            }
        
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readFromJSON(file at: URL) -> String {
        let fileContents = FileManager.default.contents(atPath: at.path)
        let fileContentsAsString = String(bytes: fileContents!, encoding: .utf8)
        
        if let fileContentsAsString = fileContentsAsString {
            return fileContentsAsString
        }
        
        return ""
    }
}
