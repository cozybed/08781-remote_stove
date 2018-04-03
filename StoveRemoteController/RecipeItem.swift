//
//  RecipeItem.swift
//  StoveRemoteController
//
//  Created by zhexi liu on 3/31/18.
//  Copyright © 2018 zhexi liu. All rights reserved.
//

import Foundation

struct RecipeItem : Codable {
    
    var name:String
    var createdAt:Date
    var id: UUID
    var description: String
    
    struct StepItem : Codable {
        var level:Int
        var timeInSeconds:Int
        
        init (level:Int, timeInSeconds:Int) {
            self.level = level
            self.timeInSeconds = timeInSeconds
        }
        
        func to_string () -> String {
            var str = "Level: " + String(self.level) + ", time: " + String(timeInSeconds) + "\n"
            return str
        }
    }
    
    var steps : [StepItem]
    
    init (name: String, id: UUID, steps: [StepItem], description: String) {
        self.name = name
        self.createdAt = Date()
        self.id = id
        self.steps = steps
        self.description = description
    }
    
    func to_string () -> String {
        
        var str = "name: " + String (self.name) + "\n"
        return str
    }
}



