//
//  ScheduleViewController.swift
//  StoveRemoteController
//
//  Created by zhexi liu on 3/31/18.
//  Copyright © 2018 zhexi liu. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var levelField: UIPickerView!
    
    @IBOutlet weak var durationField: UITextField!
    
    @IBOutlet weak var durationSecField: UITextField!
    
    @IBOutlet var startScheduleView: UIView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var pickerData = ["1", "2", "3","4","5", "6", "7", "8", "9"]
    var stepList = [RecipeItem.StepItem]()
    var selected : String = "1"
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    
    @IBAction func addStageClicked(_ sender: Any) {
        
        let duration_min: String = durationField.text!
        let duration_sec: String = durationSecField.text!
    
        let total_duration = Int(duration_min)! * 60 + Int(duration_sec)!
        let step = RecipeItem.StepItem(level: Int(selected)!, timeInSeconds: total_duration)
        self.stepList.append(step)
        self.myTableView.reloadData()
    }
    
    
    
    @IBAction func StartSchedule(_ sender: Any) {
        popUp2()
        
    }
    
    @IBAction func cancelSchedule(_ sender: Any) {
        popDown2()
    }
    @IBAction func goStartSchedule(_ sender: Any) {
        globalStepList = self.stepList
        startSchedule = true
        
        self.tabBarController?.selectedIndex = 0
        popDown2()
    }
    
    func popUp2() {
        self.view.addSubview(self.startScheduleView)
        self.startScheduleView.center = self.view.center
        self.startScheduleView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.startScheduleView.alpha = 0;
        UIView.animate(withDuration: 0.5){
            self.blurView.alpha = 1
            self.blurView.effect = self.blurEffect
            self.startScheduleView.alpha = 1
            self.startScheduleView.transform = CGAffineTransform.identity
        }
    }
    func popDown2() {
        UIView.animate(withDuration: 0.5, animations: {
            self.startScheduleView.alpha = 0
            self.startScheduleView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.blurView.effect = nil
            self.blurView.alpha = 0
        }
            , completion: {(success : Bool) in
                self.startScheduleView.removeFromSuperview()
        })
    }
    
    

    @IBOutlet var popUpView: UIView!

    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var inputNameField: UITextField!
    var blurEffect: UIVisualEffect!
    
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        print ("Loaded schedule view controller.")
        self.durationField.text = "1"
        self.durationField.delegate = self
        self.durationSecField.text = "0"
        self.durationSecField.delegate = self
        self.levelField.delegate = self
        self.blurEffect = self.blurView.effect
        self.blurView.alpha = 0
        self.blurView.isUserInteractionEnabled = false
        self.blurView.effect = nil
        self.popUpView.layer.cornerRadius = 15
        
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        view.addGestureRecognizer(swipeUp)

        
//        stageTextField.isEditable = false
        
        
        //create table view
        myTableView.register(
            UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
//        // 分隔線的樣式
        //myTableView.separatorStyle = .singleLine
//
//        // 分隔線的間距 四個數值分別代表 上、左、下、右 的間距
//        myTableView.separatorInset =
//            UIEdgeInsetsMake(0, 20, 0, 20)
//
//        // 是否可以點選 cell
//        myTableView.allowsSelection = true
//
//        // 是否可以多選 cell
//        myTableView.allowsMultipleSelection = false
       

        
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

    
    
    @IBOutlet weak var descriptionViewField: UITextView!
    
    @IBAction func cancelSave(_ sender: Any) {
        popDown()
    }
    @IBAction func popUpSaveItemAction(_ sender: Any) {
        
        let recipeItem = RecipeItem(name: inputNameField.text!, id: UUID.init(), steps: self.stepList, description: descriptionViewField.text!)
        DataManager.save (recipeItem, with: recipeItem.id.uuidString)

        popDown()
    }
    @IBAction func saveRecipeAction(_ sender: Any) {
        popUp()
    }
    func popUp() {
        self.view.addSubview(self.popUpView)
        self.popUpView.center = self.view.center
        self.popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.popUpView.alpha = 0;
        UIView.animate(withDuration: 0.5){
            self.blurView.alpha = 1
            self.blurView.effect = self.blurEffect
            self.popUpView.alpha = 1
            self.popUpView.transform = CGAffineTransform.identity
        }
    }
    func popDown() {
        UIView.animate(withDuration: 0.5, animations: {
            self.popUpView.alpha = 0
            self.popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.blurView.effect = nil
            self.blurView.alpha = 0
        }
            , completion: {(success : Bool) in
                self.popUpView.removeFromSuperview()
        })
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
        return pickerData[row]
    }
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
}
