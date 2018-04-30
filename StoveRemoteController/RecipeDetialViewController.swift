//
//  RecipeDetialViewController.swift
//  StoveRemoteController
//
//  Created by zhexi liu on 3/31/18.
//  Copyright © 2018 zhexi liu. All rights reserved.
//

import UIKit

class RecipeDetialViewController: UIViewController {

    
    @IBOutlet weak var recipeTitleLabel: UILabel!
    
    @IBOutlet weak var stageTextView: UITextView!
    
    @IBOutlet weak var descLabel: UITextView!
    
    
    @IBAction func deleteRecipeButtonClicked(_ sender: Any) {
       
        let cur_recipe = recipe_arr[myIndex]
        DataManager.delete(cur_recipe.id.uuidString)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        let cur_recipe = recipe_arr[myIndex]
        recipeTitleLabel.text = cur_recipe.name
        var steps_str = ""
        
        for s in cur_recipe.steps {
            steps_str += s.to_string() + "\n"
        }
        
        stageTextView.text = steps_str
        if (cur_recipe.description.isEmpty) {
            descLabel.text = "(user has not yet entered any description..)"
        }else{
            descLabel.text = cur_recipe.description
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
