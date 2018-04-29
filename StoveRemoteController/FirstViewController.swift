//
//  FirstViewController.swift
//  StoveRemoteController
//
//  Created by zhexi liu on 2/28/18.
//  Copyright © 2018 zhexi liu. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController {

    @IBOutlet weak var stoveImg: UIImageView!
    
    @IBOutlet var progressView: UIView!
    
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        self.last_position = touch.location(in: self.view)
        
    }
    func rotate() -> Float{
        stoveImg.transform = CGAffineTransform(rotationAngle: self.rotation)
        return Float(self.rotation) * (180/Float.pi)
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
        print("rotation\(rad1)")
        print("touch location\(location)")
        let rad2 = get_rad(point: location)
        self.rotation += (rad2 - rad1)
        self.last_position = location
        deg = rotate()
       
        print (deg)
    }
 
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dataRequestByAngle(param: String(deg), turnAngleTo : "turnAngleTo")

    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stoveImg.isUserInteractionEnabled = true
        self.center = stoveImg.center
        print(center)
        
        
//        let button = UIButton()
////        button.frame = CGRect(x: self.view.frame.size.width - 60, y: 60, width: 50, height: 50)
//        button.frame = CGRect(x: self.center.x, y: self.center.x, width: 12, height: 22)
//        button.backgroundColor = UIColor.red
//        button.setTitle("Name your Button ", for: .normal)
//        self.view.addSubview(button)
//        progressView.transform.scaledBy(x: 1, y: 20)
//        var transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 6.0)
        
        
        
        
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
        drawProgress()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(FirstViewController.tickDown)), userInfo: nil, repeats: true)

    }
    func drawProgress(){
        for index in 0..<self.progressList.count{
            self.progressList[index]?.removeFromSuperview()
            self.textViewList[index]?.removeFromSuperview()
        }
        print("hhhhh")
        self.progressList.removeAll()
        self.textViewList.removeAll()
        
        for index in 0..<self.stepList.count{
            let pp = UIProgressView(progressViewStyle: .default)
            let thisFrame = CGRect(x: 40, y: 100 + index * 100, width: Int(self.view.frame.width - 100), height: 20)
            let thisFrame2 = CGRect(x: 40, y: 100 + index * 100 - 10, width: Int(self.view.frame.width - 100), height: 20)
            pp.frame = thisFrame
            pp.tintColor = UIColor.gray
            pp.trackTintColor = UIColor.black
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
        print("asdf")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func rotateStove(direction: String) {
//        if direction == "clockwise" {
//            rotation = rotation + 360/8
//
//        }
//        else {
//            rotation = rotation - 360/8
//
//        }
//        self.stoveImg.transform = CGAffineTransform(rotationAngle: (CGFloat((rotation * .pi) / 360.0)))
//    }
    
    
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



