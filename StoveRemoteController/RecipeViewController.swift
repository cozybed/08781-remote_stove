//
//  RecipeViewController.swift
//  StoveRemoteController
//
//  Created by zhexi liu on 3/31/18.
//  Copyright © 2018 zhexi liu. All rights reserved.
///Users/yousihan/Desktop/IOT/08781-remote_stove/StoveRemoteController/RecipeViewController.swift

import UIKit

var recipe_arr_str = [String]()

let recipe1 = RecipeItem(name:"Tomato Soup", id: UUID.init(), steps:[], description:"3 Tomatos\n 1 can of tomato sause\n 1 onion\n")

var recipe_arr = [recipe1]

var myIndex = 0

class RecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func AddNewRecipe(_ sender: Any) {
        print (recipe_arr.count)
        myIndex = recipe_arr.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return recipe_arr_str.count
    }
    
  
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell" )
        cell.textLabel?.text = recipe_arr_str[indexPath.row]
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        print("recipe view will appear")
        recipe_arr = DataManager.loadAll(RecipeItem.self)
        recipe_arr_str.removeAll()
        for recipe in recipe_arr {
            recipe_arr_str.append(recipe.name)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Loaded recipe view controller.")

//
//        let step1  = RecipeItem.StepItem(level:1,timeInSeconds:10)
//        let step2  = RecipeItem.StepItem(level:3,timeInSeconds:20)
//        let steps = [step1, step2]
//        let recipe1 = RecipeItem(name:"Tomato Soup", id: UUID.init(), steps:steps, description:"3 Tomatos\n 1 can of tomato sause\n 1 onion\n")
//        let recipe2 = RecipeItem(name:"Ramen", id: UUID.init(), steps:steps, description: "water 300cc bring to boil.")
//        let recipe3 = RecipeItem(name:"Hard Boiled Eggs", id: UUID.init(), steps:steps, description: "8 mins")
//
//
//        recipe_arr = [recipe1, recipe2, recipe3]
//
//        recipe_arr = DataManager.loadAll(RecipeItem.self)
//
//        for recipe in recipe_arr {
//            recipe_arr_str.append(recipe.name)
//        }
////        recipe_arr_str = ["Tomato Soup", "Ramen", "Hard Boiled Eggs"]
//
//
//
//        print (recipe1)


    
    
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
