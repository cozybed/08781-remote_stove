//
//  AuthViewController.swift
//  StoveRemoteController
//
//  Created by zhexi liu on 4/28/18.
//  Copyright © 2018 zhexi liu. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    @IBAction func enterButton(_ sender: UIButton) {
        let res = testfunc()
        print (res)
        self.performSegue(withIdentifier: "FirstViewID", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("aaa")
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
    
    func testfunc () -> Bool {
        return false
    }

}
