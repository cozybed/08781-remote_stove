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
    
    
    
    struct StepItem : Codable {
        var level:Int
        var timeInSeconds:Int
    }
    
    var steps : [StepItem]
}



