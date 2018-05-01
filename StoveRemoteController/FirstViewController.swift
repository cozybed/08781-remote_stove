//
//  FirstViewController.swift
//  StoveRemoteController
//
//  Created by zhexi liu on 2/28/18.
//  Copyright © 2018 zhexi liu. All rights reserved.
//

import UIKit
import LocalAuthentication
var startSchedule = false
var globalStepList = [RecipeItem.StepItem]();


class FirstViewController: UIViewController {

    @IBOutlet weak var stoveImg: UIImageView!
    
    var direction = "clockwise"
    var location:CGPoint = CGPoint()
    var last_position = CGPoint()
    var rotation : CGFloat = 0
    var center = CGPoint()
    var progress: UIProgressView? = nil
    var progressList = [UIProgressView?]()
    var textViewList = [UILabel?]()
    var deg: Float = 0.0
    var stepNumber = 0;
    var stepList = [RecipeItem.StepItem]();
    var timer: Timer? = nil
    let progress_bar_count = 2
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        self.last_position = touch.location(in: self.view)
        
    }
    
    func rotate() -> Float{
        stoveImg.transform = CGAffineTransform(rotationAngle: self.rotation)
        return Float(self.rotation) * (180/Float.pi)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if startSchedule && self.stepList.count != 0{
            self.stepList = globalStepList
            drawProgress()
            startSchedule = false
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(FirstViewController.tickDown)), userInfo: nil, repeats: true)
        }
    }
    
    func get_rad(point: CGPoint) ->CGFloat  {
        if point.x == 0{
            if point.y > self.stoveImg.center.y{
                return 0
            }
            else{
                return CGFloat(Float.pi)
            }
        }
        let dif_x = point.x - self.center.x
        let dif_y = point.y - self.center.y
        if point.x > self.stoveImg.center.x{
            return atan(dif_y/dif_x)
        }
        return atan(dif_y/dif_x) + CGFloat(Float.pi)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self.view)
        let rad1 = get_rad(point: self.last_position)
        let rad2 = get_rad(point: location)
        self.rotation += (rad2 - rad1)
        self.last_position = location
        deg = rotate()
    }
 
    
    @IBOutlet weak var levelIndicatorLabel: UILabel!
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var degree = Int(deg) % 360
        if degree < 0 {
            degree += 360
        }
        let level = degree / 40 + 1
        levelIndicatorLabel.text = "LEVEL: \(level)"
        print("rotate to \(degree)")
        dataRequestByAngle(param: String(degree), turnAngleTo : "turnAngleTo")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stoveImg.isUserInteractionEnabled = true
        self.center = stoveImg.center
        print(center)
        
    
        let step1  = RecipeItem.StepItem(level:1,timeInSeconds:2)
        let step2  = RecipeItem.StepItem(level:2,timeInSeconds:4)
        let step3  = RecipeItem.StepItem(level:3,timeInSeconds:6)
        let step4  = RecipeItem.StepItem(level:4,timeInSeconds:8)
        var stepList = [RecipeItem.StepItem]()
        stepList.append(step1)
        stepList.append(step2)
        stepList.append(step3)
        stepList.append(step4)
        self.stepList = stepList;
    }
    
    
    func drawProgress(){
        for index in 0..<self.progressList.count{
            self.progressList[index]?.removeFromSuperview()
            self.textViewList[index]?.removeFromSuperview()
        }

        self.progressList.removeAll()
        self.textViewList.removeAll()
        for index in 0..<self.stepList.count {
            let pp = UIProgressView(progressViewStyle: .default)
            let thisFrame = CGRect(x: 50, y: 100 + index * 100, width: Int(self.view.frame.width - 100), height: 20)
            let thisFrame2 = CGRect(x: 50, y: 100 + index * 100 - 10, width: Int(self.view.frame.width - 100), height: 20)
            pp.frame = thisFrame
            pp.tintColor = UIColor.gray
            pp.trackTintColor = UIColor.lightGray
            pp.transform = CGAffineTransform(scaleX: 1, y: 20)
            pp.setProgress(0.0, animated: true)
            pp.layer.borderColor = UIColor.gray.cgColor
            let textView = UILabel(frame:thisFrame2)
            textView.text = "level \(self.stepList[index].level) + for \(self.stepList[index].timeInSeconds) seconds"
            textView.textAlignment = NSTextAlignment.center
            textView.numberOfLines = 0
            textView.layer.borderColor = UIColor.black.cgColor
            textView.backgroundColor = UIColor.clear
            textView.textColor = UIColor.white
            self.view.addSubview(pp)
            self.view.addSubview(textView)
            self.progressList.append(pp)
            self.textViewList.append(textView)
            if index == 2{
                break;
            }
        }
        if self.stepList.count > 0 {
            let setDeg = self.stepList[0].level * 40
            print("auto setup \(setDeg)")
            self.rotation = CGFloat(setDeg)
            self.levelIndicatorLabel.text = "LEVEL: \(self.stepList[0].level)"
            deg = rotate()
        }
        self.progress = self.progressList.first!
        
    }
    
    @objc func tickDown()
    {
        self.progress!.setProgress(self.progress!.progress + 1 / Float(self.stepList[0].timeInSeconds), animated: true)
        if self.progress!.progress >= 1.0{
            self.stepList.removeFirst()
            if self.stepList.count == 0 {
                timer!.invalidate()
                return
            }
            drawProgress()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataRequestByAngle(param: String, turnAngleTo : String) {
        
        let urlToRequest = "https://api.particle.io/v1/devices/33001c000347353137323334/\(turnAngleTo)?access_token=30a9c72b4fad3857cd88aeaebdc4e4ce03e8e1c3"
        
        print (urlToRequest)
        
        let url4 = URL(string: urlToRequest)!
        let session4 = URLSession.shared
        let request = NSMutableURLRequest(url: url4)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        let paramString = "arg=\(param)"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        let task = session4.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let _: Data = data, let _: URLResponse = response, error == nil else {
                print("*****error")
                return
            }
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("*****This is the data 4: \(String(describing: dataString))") //JSONSerialization
        }
        task.resume()
    }
    
    
    func dataRequest(param: String, dir : String) {
        
        let urlToRequest = "https://api.particle.io/v1/devices/33001c000347353137323334/\(dir)?access_token=30a9c72b4fad3857cd88aeaebdc4e4ce03e8e1c3"
        
        print (urlToRequest)
        
        let url4 = URL(string: urlToRequest)!
        let session4 = URLSession.shared
        let request = NSMutableURLRequest(url: url4)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        let paramString = "arg=\(param)"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        let task = session4.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let _: Data = data, let _: URLResponse = response, error == nil else {
                print("*****error")
                return
            }
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("*****This is the data 4: \(String(describing: dataString))") //JSONSerialization
        }
        task.resume()
    }
    

    @IBAction func turnButtonClicked(_ sender: Any) {
                if self.direction == "clockwise" {
            dataRequest(param: "anti_clockwise", dir : "diraction")
            self.direction = "anti-clockwise"
        }
        else {
            dataRequest(param: "clockwise", dir : "diraction")
            self.direction = "clockwise"
        }
    }
}
