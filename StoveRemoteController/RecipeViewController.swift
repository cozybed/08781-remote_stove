//
//  RecipeViewController.swift
//  StoveRemoteController
//
//  Created by zhexi liu on 3/31/18.
//  Copyright © 2018 zhexi liu. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Loaded recipe view controller.")
        
        var step1  = RecipeItem.StepItem(level:1,timeInSeconds:10)
        
        var recipe1 = RecipeItem(name:"Tomato Soup", id: UUID.init(), steps:[step1])
        
        print (step1)
        print (recipe1)
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
