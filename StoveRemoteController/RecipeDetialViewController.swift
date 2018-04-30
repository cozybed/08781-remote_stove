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
    
    /*
    func testSave(_ sender: Any) {
        
        //DataManager.save (recipe_arr[0], with: "testRecipie.log")
        var all_data = DataManager.loadAll( RecipeItem.self)
        print (all_data)
    }*/
    
    @IBAction func deleteRecipeButtonClicked(_ sender: Any) {
       
        let cur_recipe = recipe_arr[myIndex]
        
        
        print ("Current index is:")
        print (myIndex)
        DataManager.delete(cur_recipe.id.uuidString)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let cur_recipe = recipe_arr[myIndex]
        recipeTitleLabel.text = cur_recipe.name
        var steps_str = ""
        
        for s in cur_recipe.steps {
            steps_str += s.to_string()
        }
        stageTextView.text = steps_str
        
        descLabel.text = cur_recipe.description
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
