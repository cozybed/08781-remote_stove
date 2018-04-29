//
//  JsonManager.swift
//  StoveRemoteController
//
//  Created by leo on 2018/3/31.
//  Copyright © 2018 zhexi liu. All rights reserved.
//


import Foundation

public class DataManager {
    
    // get Document Directory
    static fileprivate func getDocumentDirectory () -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        }else{
            fatalError("Unable to access document directory")
        }
    }
    
    // Save any kind of codable objects
    static func save <T:Encodable> (_ object:T, with fileName:String) {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        print (url)
        do {
            let data = try JSONEncoder().encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
            
        }catch{
            fatalError(error.localizedDescription)
        }
        
    }

    // Load any kind of codable objects
    static func load <T:Decodable> (_ fileName:String, with type:T.Type) -> T? {
        print(fileName)
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("File not found at path \(url.path)")
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            do {
                let model = try JSONDecoder().decode(type, from: data)
                print("format correct\(fileName)")
                return model
            }catch{
                return nil
//                fatalError(error.localizedDescription)
            }
            
        }else{
            fatalError("Data unavailable at path \(url.path)")
        }
    }
    
    // Load all files from a directory
    static func loadAll <T:Decodable> (_ type:T.Type) -> [T] {
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: getDocumentDirectory().path)
            
            var modelObjects = [T]()
            
            for fileName in files {
                let load_item: T? = load(fileName, with: type)
                if load_item != nil {
                    modelObjects.append(load_item!)
                }
                
            }
            
            return modelObjects
            
            
        }catch{
            fatalError("could not load any files")
        }
    }
    
    
    // Delete a file
    static func delete (_ fileName:String) {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        print("want to delete \(fileName)")
        if FileManager.default.fileExists(atPath: url.path) {
            print("file exists")
            do {
                try FileManager.default.removeItem(at: url)
            }catch{
                fatalError(error.localizedDescription)
            }
        }
    }

    
}
