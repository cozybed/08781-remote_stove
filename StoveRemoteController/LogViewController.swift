//
//  SecondViewController.swift
//  StoveRemoteController
//
//  Created by zhexi liu on 2/28/18.
//  Copyright © 2018 zhexi liu. All rights reserved.
//

import UIKit
var globalRecipe = [[RecipeItem.StepItem]]()
var globalStartDate = [Date]()
class LogViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var myTableView: UITableView = UITableView()
    var scheduleTimer = [Timer]()
    override func viewWillAppear(_ animated: Bool) {
        self.myTableView.reloadData()
        for aTimer in self.scheduleTimer {
            aTimer.invalidate()
        }
        self.scheduleTimer.removeAll()
        for index in 0..<globalRecipe.count {
            
            let aDate = globalStartDate[index].timeIntervalSinceReferenceDate
            let currentDate = Date().timeIntervalSinceReferenceDate
            let interval = aDate - currentDate
            if interval < 0 {
                continue
            }
            let steps = globalRecipe[index]
            //todo: check for start time
            
            let aTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector:#selector(startAnSchedule(sender:)), userInfo: steps, repeats:false)
            self.scheduleTimer.append(aTimer)
        }
    }
    
    @objc func startAnSchedule(sender: Timer){
        print("add a schedulre")
        globalStepList = sender.userInfo as! [RecipeItem.StepItem]
        startSchedule = true
        self.tabBarController?.selectedIndex = 0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        let step1  = RecipeItem.StepItem(level:1,timeInSeconds:10)
//        let step2  = RecipeItem.StepItem(level:3,timeInSeconds:20)
//        let steps = [step1, step2]
//        globalRecipe.append(steps)
//        globalRecipe.append(steps)
//        globalRecipe.append(steps)
//        globalRecipe.append(steps)
//        globalStartDate.append(Date())
//        globalStartDate.append(Date())
//        globalStartDate.append(Date())
//        globalStartDate.append(Date())
        print ("Loaded log view controller.")
        
        //create table view
        let fullScreenSize = UIScreen.main.bounds.size
        self.myTableView = UITableView(frame: CGRect(
            x: 0, y: 60,
            width: fullScreenSize.width,
            height: fullScreenSize.height - 20),
                                      style: .grouped)

        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(LogViewController.refreshTable), userInfo: nil, repeats: true)
        
        
        // cited from https://itisjoe.gitbooks.io/swiftgo/content/uikit/uitableview.html
        // 註冊 cell
        myTableView.register(
            UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // 設置委任對象
        myTableView.delegate = self
        myTableView.dataSource = self
        
        // 分隔線的樣式
        myTableView.separatorStyle = .singleLine
        
        // 分隔線的間距 四個數值分別代表 上、左、下、右 的間距
        myTableView.separatorInset =
            UIEdgeInsetsMake(0, 20, 0, 20)
        self.myTableView.backgroundColor = UIColor.clear
        // 是否可以點選 cell
        myTableView.allowsSelection = true
        
        // 是否可以多選 cell
        myTableView.allowsMultipleSelection = false
        
        // 加入到畫面中
        self.view.addSubview(myTableView)
        
    }
    
    @objc func refreshTable(){
        self.myTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalRecipe[section].count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return globalRecipe.count
    }
    // 必須實作的方法：每個 cell 要顯示的內容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
//            // 顯示的內容
            print("\(indexPath.row)\(indexPath.section)")
            let step = globalRecipe[indexPath.section][indexPath.row]
            cell?.textLabel?.text = "level \(step.level) for \(step.timeInSeconds) seconds"
            
            
            return cell!
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle:   UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            globalRecipe.remove(at: indexPath.section)
            globalStartDate.remove(at: indexPath.section)
            self.scheduleTimer.remove(at: indexPath.section)
            tableView.beginUpdates()
            tableView.deleteSections([indexPath.section], with: .middle)
            tableView.endUpdates()
        }
    }

    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "en_US")
        let title = dateFormatter.string(from: globalStartDate[section])
        let remainTime = Int(globalStartDate[section].timeIntervalSinceReferenceDate - Date().timeIntervalSinceReferenceDate)
        
        return title + " \(remainTime) seconds remaining"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

