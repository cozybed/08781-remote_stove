//
//  RecipeEditViewController.swift
//  StoveRemoteController
//
//  Created by zhexi liu on 4/3/18.
//  Copyright © 2018 zhexi liu. All rights reserved.
//

import UIKit

class RecipeEditViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource  {
    
    var stepList = [RecipeItem.StepItem]()
    var selected : String = "1"
    var pickerData = ["1", "2", "3","4","5", "6", "7", "8", "9"]

    @IBOutlet weak var recipeNameField: UITextField!
    @IBOutlet weak var recipeDescriptionField: UITextView!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var levelField: UIPickerView!
    
    @IBOutlet weak var durationMinField: UITextField!
    
    @IBOutlet weak var durationSecField: UITextField!
    
    @IBAction func addStageClicked(_ sender: Any) {
        let duration_min: String = durationMinField.text!
        let duration_sec: String = durationSecField.text!
        
        let total_duration = Int(duration_min)! * 60 + Int(duration_sec)!
        let step = RecipeItem.StepItem(level: Int(selected)!, timeInSeconds: total_duration)
        self.stepList.append(step)
        self.tableView.reloadData()

    }
    
    @IBAction func saveEditClicked(_ sender: Any) {
        if (myIndex == recipe_arr.count){
            let cur_recipe = RecipeItem(name: recipeNameField.text!, id: UUID.init(), steps: self.stepList, description: recipeDescriptionField.text!)
            DataManager.save (cur_recipe, with: cur_recipe.id.uuidString)
            

        }else{
            
            var cur_recipe = recipe_arr [myIndex]
            cur_recipe.steps = self.stepList
            cur_recipe.name = recipeNameField.text!
            cur_recipe.description = recipeDescriptionField.text!
            DataManager.save (cur_recipe, with: cur_recipe.id.uuidString)
        }
        
        
    }
    
    
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
        
        
        self.durationMinField.text = "1"
        self.durationSecField.text = "0"
        self.levelField.delegate = self

        
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
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selected = pickerData[row]
        return selected
    }
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }

}
