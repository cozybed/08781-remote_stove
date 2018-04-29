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
    @IBAction func testSave(_ sender: Any) {
        
        //recipe_arr
        //DataManager.save (recipe_arr[0], with: "testRecipie.log")
        
        var all_data = DataManager.loadAll( RecipeItem.self)
        print (all_data)
        
        var blah = ""
        for data in all_data {
            blah += data.to_string()
        }
        
        descLabel.text  = blah
        
    }*/
    
    @IBAction func deleteRecipeButtonClicked(_ sender: Any) {
       
        var cur_recipe = recipe_arr[myIndex]
        
        DataManager.delete(cur_recipe.name)
        recipe_arr.remove(at: myIndex)
        myIndex = 0
        
        print (recipe_arr.count)
        
        /*
        let next:UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "all_recipe_board"))!
        
        self.present(next, animated: true, completion: nil)
        
        print ("Deleted: ")
        print (cur_recipe.name)*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var cur_recipe = recipe_arr[myIndex]
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
