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
    
    
    var direction = "clockwise"
    
    var rotation : CGFloat  = 0
    
    var location:CGPoint = CGPoint()
    var deg: CGFloat = 0
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: touch.view)
        self.location = location
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: touch.view)
        let move_x = location.x - self.location.x
        let move_y = location.y - self.location.y
        let deg = atan(move_y/move_x)
        self.deg = deg
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: touch.view)
        print(self.deg)
        rotateStove(direction: self.direction)
        dataRequest(param: "pulse", dir : "pulse")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stoveImg.isUserInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rotateStove(direction: String) {
        if direction == "clockwise" {
            rotation = rotation + 360/8

        }
        else {
            rotation = rotation - 360/8

        }
        self.stoveImg.transform = CGAffineTransform(rotationAngle: (CGFloat((rotation * .pi) / 360.0)))
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
            print("*****This is the data 4: \(dataString)") //JSONSerialization
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

