//
//  RecipeEditViewController.swift
//  StoveRemoteController
//
//  Created by zhexi liu on 4/3/18.
//  Copyright © 2018 zhexi liu. All rights reserved.
//

import UIKit

class RecipeEditViewController: UIViewController {
    @IBOutlet weak var recipeNameField: UITextField!
    
    
    @IBOutlet weak var recipeDescriptionField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print ("In recipe edit view. current index is: ")
        print (myIndex)
        
        
        //Create new recipe vs edit old recipe
        if (myIndex == recipe_arr.count){
            
        }else{
            
            let curRecipe = recipe_arr [myIndex]
            recipeNameField.text = curRecipe.name
            recipeDescriptionField.text = curRecipe.description
        }
        
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RecipeEditViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
