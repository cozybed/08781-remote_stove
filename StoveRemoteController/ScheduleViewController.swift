//
//  ScheduleViewController.swift
//  StoveRemoteController
//
//  Created by zhexi liu on 3/31/18.
//  Copyright © 2018 zhexi liu. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var levelField: UIPickerView!
    
    @IBOutlet weak var durationField: UITextField!
    
    @IBOutlet weak var stageTextField: UITextView!
    var pickerData = ["1", "2", "3","4","5", "6", "7", "8", "9"]
    
    var selected : String = "1"
    @IBAction func addStageClicked(_ sender: Any) {
        
        var duration: String = durationField.text!
        var txt : String  = stageTextField.text
        txt += "\nLevel:" + selected + " for " + duration + " mins."
        stageTextField.text = txt
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print ("Loaded schedule view controller.")
        
        self.levelField.delegate = self
        self.levelField.delegate = self
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
