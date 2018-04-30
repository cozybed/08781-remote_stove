//
//  RecipeEditViewController.swift
//  StoveRemoteController
//
//  Created by zhexi liu on 4/3/18.
//  Copyright © 2018 zhexi liu. All rights reserved.
//

import UIKit

class RecipeEditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var recipeNameField: UITextField!
    @IBOutlet weak var recipeDescriptionField: UITextView!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var stepList = [RecipeItem.StepItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print ("In recipe edit view. current index is: ")
        print (myIndex)
        
        //Create new recipe vs edit old recipe
        if (myIndex == recipe_arr.count){
            
        }else{
            
            let cur_recipe = recipe_arr [myIndex]
            self.stepList = cur_recipe.steps
            
            recipeNameField.text = cur_recipe.name
            recipeDescriptionField.text = cur_recipe.description
            
        }
        
        tableView.register(
            UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RecipeEditViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.stepList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // contents of the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell")
        // display on cell
        let time_in_sec_tot = self.stepList[indexPath.row].timeInSeconds
        let time_in_min = time_in_sec_tot / 60
        let time_in_sec = time_in_sec_tot % 60
        let cellText = "level \(self.stepList[indexPath.row].level) for \(time_in_min) mins and \(time_in_sec) seconds"
        cell?.textLabel?.text = cellText
        cell?.backgroundColor =  UIColor(red:0.84, green:0.76, blue:0.76, alpha:1.0)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle:   UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.stepList.remove(at: indexPath.section)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .middle)
            tableView.endUpdates()
        }
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

}
