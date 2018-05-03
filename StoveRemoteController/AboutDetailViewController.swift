//
//  AboutDetailViewController.swift
//  StoveGuard
//
//  Created by zhexi liu on 5/3/18.
//  Copyright © 2018 zhexi liu. All rights reserved.
//

import UIKit


class AboutDetailViewController: UIViewController {
    
    
    var selected : Int = -1
    var about_item_str: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (about_item_str)
        // Do any additional setup after loading the view.
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
