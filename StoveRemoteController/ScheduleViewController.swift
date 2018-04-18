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
    
    
    
    
    

    @IBOutlet var popUpView: UIView!

    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var inputNameField: UITextField!
    var blurEffect: UIVisualEffect!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print ("Loaded schedule view controller.")

        self.levelField.delegate = self
        self.levelField.delegate = self
        self.blurEffect = self.blurView.effect
        self.blurView.isUserInteractionEnabled = false
        self.blurView.effect = nil
        self.popUpView.layer.cornerRadius = 5

    }


    @IBAction func popUpSaveItemAction(_ sender: Any) {
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
