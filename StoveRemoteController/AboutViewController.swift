//
//  AboutViewController.swift
//  StoveGuard
//
//  Created by zhexi liu on 5/3/18.
//  Copyright © 2018 zhexi liu. All rights reserved.
//

import UIKit

var about_items = [String]()

class AboutViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var aboutTableView: UITableView!
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return about_items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell" )
        cell.textLabel?.text = about_items[indexPath.row]
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        myIndex = indexPath.row
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.aboutTableView.delegate = self
        self.aboutTableView.dataSource = self
        about_items = ["Product Information", "Acoount Settings", "Privacy Policy", "About Us"]
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
