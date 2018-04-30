//
//  ScheduleViewController.swift
//  StoveRemoteController
//
//  Created by zhexi liu on 3/31/18.
//  Copyright © 2018 zhexi liu. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var levelField: UIPickerView!
    
    @IBOutlet weak var durationField: UITextField!
    
    @IBOutlet weak var durationSecField: UITextField!
    
    @IBOutlet weak var stageTextField: UITextView!
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
        
        
        var txt : String  = stageTextField.text
        txt += "\nLevel " + selected + " for " + duration_min + " mins " + duration_sec + " secs. \n"
        stageTextField.text = txt
        
        let total_duration = Int(duration_min)! * 60 + Int(duration_sec)!
        let step = RecipeItem.StepItem(level: Int(selected)!, timeInSeconds: total_duration)
        self.stepList.append(step)
    }
    
    
    @IBOutlet var startScheduleView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func StartSchedule(_ sender: Any) {
//        let sb = UIStoryboard(name:"Main", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "FirstViewID") as UIViewController
//        self.present(vc, animated: true, completion: nil)
//        self.presentingViewController(vc, animated: true, completion: nil)
        popUp2()
        
    }
    
    @IBAction func goStartSchedule(_ sender: Any) {
        globalStepList = self.stepList
        startSchedule = true
        self.stageTextField.text = ""
        self.tabBarController?.selectedIndex = 0;
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

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        print ("Loaded schedule view controller.")
//        self.durationField.delegate = self
//        self.levelField.delegate = self
//        self.levelField.delegate = self
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

        
        stageTextField.isEditable = false
    }

    @objc func dismissKeyboard(){
        self.view.endEditing(true)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
}
